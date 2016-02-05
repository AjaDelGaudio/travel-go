feature "user edits a link", %(
  As a last minute traveler or traveler who's stay is unexpectedly extended,
  I want to edit a link
  So I can make changes any time.
) do
  # Acceptance Criteria
  # [] I can edit existing links
  # [] I can more links to an adventure
  # [] If I add a link, I must submit a link address
  # [] If I add a link, I may also add a link name
  # [] I can click a button to add a new link

  scenario "authenticated user successfully adds a link to an adventure" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    bucket_list = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      title: "Second Bucket List"
    )
    adventure = FactoryGirl.create(:adventure, user_id: user.id)
    bucket_list_adventure = FactoryGirl.create(
      :bucket_list_adventure,
      adventure_id: adventure.id,
      bucket_list_id: bucket_list.id
    )
    link = FactoryGirl.create(:link, user_id: user.id, adventure_id: adventure.id)

    visit edit_adventure_path(adventure)
    click_button "Add link"
    
    link_name_fields = page.all("Link name:")
    fill_in link_name_fields[1], with: "Wikitravel - Jinja"

    link_address_fields = page.all("Link address:")
    fill_in link_address_fields[1], with: "wikitravel.org/en/Jinja"

    click_button "Save It!"

    expect(page).to have_content("Changes saved!")
    expect(page).not_to have_content("Address can't be blank")
    expect(page).not_to have_content("Link address can't be blank")
  end
end
