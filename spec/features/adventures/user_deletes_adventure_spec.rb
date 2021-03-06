require "rails_helper"

feature "authenticated user deletes an adventure", %(
  As a last minute traveler or traveler who's stay is unexpectedly extended,
  I want to delete an adventure
  So I can throw away my dreams.
) do
# Acceptance Criteria
# [x] I can click a link to delete an adventure
# [x] I receive an success message after deleting an adventure
# [x] After I delete an adventure it is no longer visible

  scenario "authenticated user sucessfully deletes an adventure" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    bucket_list = FactoryGirl.create(
      :bucket_list,
      title: "Australia",
      user_id: user.id
    )
    adventure = FactoryGirl.create(:adventure, user_id: user.id)
    bucket_list_adventure = FactoryGirl.create(
      :bucket_list_adventure,
      adventure_id: adventure.id,
      bucket_list_id: bucket_list.id
    )

    visit edit_adventure_path(adventure)
    click_link "Delete"

    expect(page).to have_content("Adventure deleted")
    expect(page).not_to have_content("Adventure NOT deleted")
    expect(page).not_to have_content(adventure.name)
  end

  scenario "unauthenticated user fails to delete an adventure" do
# cannot navigate to edit_adventure_path(adventure) w/o being logged in
    visit bucket_lists_path

    expect(page).to have_content("Log in")
    expect(page).not_to have_content("Edit")
  end
end
