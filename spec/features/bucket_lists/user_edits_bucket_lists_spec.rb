require "rails_helper"

feature "authenticated user edits a bucket list", %(
  As a last minute traveler or traveler who's stay is unexpectedly extended,
  I want to edit a bucket list
  So I can later recall the destinations without weighing down my bag or mind.
) do
# Acceptance Criteria
# [x] I can change the title and description
# [x] I must click submit to save my changes
# [x] I can toggle between private and public

  scenario "user successfully changes the title of a bucket list" do
    user = FactoryGirl.create(:user)
    bucket_list_sign_in(user)
    visit edit_bucket_list_path(bucket_list)
    fill_in "Title", with: "Africa"
    fill_in "Description", with: "Much warmer!"
    click_button "Save It!"

    expect(page).to have_content("Changes saved!")
    expect(page).to have_content("My Bucket Lists")
    expect(page).to have_content("Add an Adventure")
  end

  scenario "user successfully changes the private setting of a bucket list" do
    user = FactoryGirl.create(:user)
    bucket_list_sign_in(user)
    visit edit_bucket_list_path(bucket_list)
    find("label", text: "Make public").click
    click_button "Save It!"

    expect(page).to have_content("Changes saved!")
    expect(page).to have_content("My Bucket Lists")
    expect(page).to have_content("Add an Adventure")
  end
end
