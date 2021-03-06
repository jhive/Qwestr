defmodule Qwestr.QwestViewTest do 
	use Qwestr.ConnCase, async: true 

	alias Qwestr.Qwest
	alias Qwestr.QwestView
	alias Qwestr.Enums.Repeat

	import Phoenix.View

	# Constants

	@valid_active_daily_qwest %Qwest{id: 1, title: "Active Daily Qwest", repeat: :daily}
	@valid_active_weekly_qwest %Qwest{id: 2, title: "Active Weekly Qwest", repeat: :weekly}
	@valid_active_monthly_qwest %Qwest{id: 3, title: "Active Monthly Qwest", repeat: :monthly}
	@valid_active_yearly_qwest %Qwest{id: 4, title: "Active Yearly Qwest", repeat: :yearly}
	@valid_active_epic_qwest %Qwest{id: 5, title: "Active Epic Qwest", repeat: :never}

	@valid_completed_daily_qwest %Qwest{id: 6, title: "Completed Daily Qwest", repeat: :daily}
	@valid_completed_weekly_qwest %Qwest{id: 7, title: "Completed Weekly Qwest", repeat: :weekly}
	@valid_completed_monthly_qwest %Qwest{id: 8, title: "Completed Monthly Qwest", repeat: :monthly}
	@valid_completed_yearly_qwest %Qwest{id: 9, title: "Completed Yearly Qwest", repeat: :yearly}
	@valid_completed_epic_qwest %Qwest{id: 10, title: "Completed Epic Qwest", repeat: :never}

	# Setup

	setup do
		{:ok, conn: conn()}
	end

	# Tests

	test "renders index.html", %{conn: conn} do 
		# create view content
		active_daily_qwests = [@valid_active_daily_qwest]
		active_weekly_qwests = [@valid_active_weekly_qwest]
		active_monthly_qwests = [@valid_active_monthly_qwest]
		active_yearly_qwests = [@valid_active_yearly_qwest]
		active_epic_qwests = [@valid_active_epic_qwest]
		completed_daily_qwests = [@valid_completed_daily_qwest]
		completed_weekly_qwests = [@valid_completed_weekly_qwest]
		completed_monthly_qwests = [@valid_completed_monthly_qwest]
		completed_yearly_qwests = [@valid_completed_yearly_qwest]
		completed_epic_qwests = [@valid_completed_epic_qwest]
		
		# render view content
		content = render_to_string(QwestView, "index.html", conn: conn, 
      active_daily_qwests: active_daily_qwests,
      active_weekly_qwests: active_weekly_qwests,
      active_monthly_qwests: active_monthly_qwests,
      active_yearly_qwests: active_yearly_qwests,
      active_epic_qwests: active_epic_qwests,
      completed_daily_qwests: completed_daily_qwests,
      completed_weekly_qwests: completed_weekly_qwests,
      completed_monthly_qwests: completed_monthly_qwests,
      completed_yearly_qwests: completed_yearly_qwests,
      completed_epic_qwests: completed_epic_qwests)

		# assert that basic information appears
		assert String.contains?(content, "Qwest List") 
		
		# assert that active qwests appear on index
		for qwest <- active_daily_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- active_weekly_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- active_monthly_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- active_yearly_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- active_epic_qwests do
    	assert String.contains?(content, qwest.title)
		end

		# assert that completed qwests appear on index
		for qwest <- completed_daily_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- completed_weekly_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- completed_monthly_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- completed_yearly_qwests do
    	assert String.contains?(content, qwest.title)
		end
		for qwest <- completed_epic_qwests do
    	assert String.contains?(content, qwest.title)
		end
	end

	test "renders new.html", %{conn: conn} do
		# create view content
		changeset = Qwest.changeset(%Qwest{}) 
		repeat_options = Repeat.select_map()

		# render view content
		content = render_to_string(QwestView, "new.html", conn: conn, changeset: changeset, repeat_options: repeat_options)

		assert String.contains?(content, "New Qwest") 
	end

	test "renders edit.html", %{conn: conn} do
		# create view content
		qwest = @valid_active_daily_qwest
		changeset = Qwest.changeset(qwest) 
		repeat_options = Repeat.select_map()

		# render view content
		content = render_to_string(QwestView, "edit.html", conn: conn, changeset: changeset, qwest: qwest, repeat_options: repeat_options)

		assert String.contains?(content, "Edit Qwest") 
	end

	test "renders show.html", %{conn: conn} do
		# create view content
		qwest = @valid_active_daily_qwest
		changeset = Qwest.changeset(qwest) 
		
		# render view content
		content = render_to_string(QwestView, "show.html", conn: conn, changeset: changeset, qwest: qwest)

		assert String.contains?(content, "Show Qwest") 
	end
end