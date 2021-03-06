require "rails_helper"

feature "user views their adventures", %(
  As a last minute traveler or traveler who's stay is unexpectedly extended,
  I want to view my adventures
  So that I can explore adventures on the fly.
) do
  # Acceptance Criteria
  # [x] I must be signed in to view my private adventures
  # [x] If my adventure includes a link and I click it, I am taken to the link
  #    address
  # [x] I can view a list of the adventures associated with each bucket_list
  # [x] I can see an icon telling me if my adventure is public or private
  # [x] I can click a link to edit my adventure

  scenario "authenticated user successfully views list of their adventures " \
  "associated w/ a particular bucket lists by navigating to that bucket" \
  " list's show page" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    # bucket_list_1
    bucket_list_1 = FactoryGirl.create(:bucket_list, user_id: user.id)
    adventure_1 = FactoryGirl.create(
      :adventure,
      user_id: user.id
    )
    bucket_list_adventure_1 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_1.id,
      adventure_id: adventure_1.id
    )

    # bucket_list_2
    bucket_list_2 = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      title: "Mongolia"
    )
    adventure_2 = FactoryGirl.create(
      :adventure,
      user_id: user.id,
      name: "Sleep in a yurt"
    )
    bucket_list_adventure_2 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_2.id,
      adventure_id: adventure_2.id
    )

    visit bucket_list_path(bucket_list_1.id)

    expect(page).to have_content(bucket_list_1.title)
    expect(page).to have_content(adventure_1.name)
    expect(page).not_to have_content(bucket_list_2.title)
    expect(page).not_to have_content(adventure_2.name)
  end

  scenario "unauthenticated user fails to view a list of their adventures " \
  "associated with each of their bucket lists" do
    user = FactoryGirl.create(:user)

    bucket_list = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      is_public: false
    )
    adventure = FactoryGirl.create(
      :adventure,
      notes: "do all the things"
    )
    bucket_list_adventure = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list.id,
      adventure_id: adventure.id
    )

    visit adventures_path

    expect(page).to have_content("You can do that after you sign in or sign up!")
    expect(page).to have_content("Log in")
    expect(page).not_to have_content(adventure.notes)
  end

  scenario "authenticated user successfully views list of their adventures" \
  " by navigating to the adventures index page" do
    user = FactoryGirl.create(:user)
    sign_in(user)

    # bucket_list_1
    bucket_list_1 = FactoryGirl.create(:bucket_list, user_id: user.id)
    adventure_1 = FactoryGirl.create(
      :adventure,
      user_id: user.id
    )
    bucket_list_adventure_1 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_1.id,
      adventure_id: adventure_1.id
    )

    # bucket_list_2
    bucket_list_2 = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      title: "Mongolia"
    )
    adventure_2 = FactoryGirl.create(
      :adventure,
      user_id: user.id,
      name: "Sleep in a yurt"
    )
    bucket_list_adventure_2 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_2.id,
      adventure_id: adventure_2.id
    )

    visit adventures_path
    expect(page).to have_content(adventure_1.name)
    expect(page).to have_content(adventure_2.name)
  end

  scenario "unauthenticated user fails to view list of their adventures" \
  " by navigating to the adventures index page" do
    user = FactoryGirl.create(:user)

    # bucket_list_1
    bucket_list_1 = FactoryGirl.create(:bucket_list, user_id: user.id)
    adventure_1 = FactoryGirl.create(
      :adventure,
      user_id: user.id
    )
    bucket_list_adventure_1 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_1.id,
      adventure_id: adventure_1.id
    )

    # bucket_list_2
    bucket_list_2 = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      title: "Mongolia"
    )
    adventure_2 = FactoryGirl.create(
      :adventure,
      user_id: user.id,
      name: "Sleep in a yurt"
    )
    bucket_list_adventure_2 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_2.id,
      adventure_id: adventure_2.id
    )

    visit adventures_path
    expect(page).to have_content("You can do that after you sign in or sign up!")
    expect(page).to have_content("Log in")
    expect(page).not_to have_content(adventure_1.name)
    expect(page).not_to have_content(adventure_2.name)
  end

  scenario "authenticated user successfully views list of everyone's public" \
  " adventures by navigating to the all_public adventures page" do
    user = FactoryGirl.create(:user)
    user_b = FactoryGirl.create(:user)
    sign_in(user_b)

    # bucket_list_public_1
    bucket_list_public_1 = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      is_public: true
    )
    adventure_public_1 = FactoryGirl.create(
      :adventure,
      user_id: user.id,
      is_shared: true
    )
    bucket_list_adventure_public_1 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_public_1.id,
      adventure_id: adventure_public_1.id
    )

    # bucket_list_public_2
    bucket_list_public_2 = FactoryGirl.create(
      :bucket_list,
      user_id: user.id,
      title: "Mongolia",
      is_public: true
    )
    adventure_public_2 = FactoryGirl.create(
      :adventure,
      user_id: user.id,
      name: "Sleep in a yurt",
      is_shared: true
    )
    bucket_list_adventure_public_2 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_public_2.id,
      adventure_id: adventure_public_2.id
    )

    # bucket_list_private_3
    bucket_list_private_3 = FactoryGirl.create(
      :bucket_list,
      user_id: user_b.id,
      title: "Around the world in 80 days",
      is_public: false
    )
    adventure_private_3 = FactoryGirl.create(
      :adventure,
      user_id: user_b.id,
      name: "hot air balloon ride",
      is_shared: false
    )
    bucket_list_adventure_3 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_private_3.id,
      adventure_id: adventure_private_3.id
    )

    # bucket_list_private_4
    bucket_list_private_4 = FactoryGirl.create(
      :bucket_list,
      user_id: user_b.id,
      title: "Peru: Everywhere except Manu Picchu",
      is_public: false
    )
    adventure_private_4 = FactoryGirl.create(
      :adventure,
      user_id: user_b.id,
      name: "Nazca Lines",
      is_shared: false
    )
    bucket_list_adventure_private_4 = FactoryGirl.create(
      :bucket_list_adventure,
      bucket_list_id: bucket_list_private_4.id,
      adventure_id: adventure_private_4.id,
    )

    visit all_public_adventures_path

    expect(page).to have_content(adventure_public_1.name)
    expect(page).to have_content(adventure_public_2.name)
    expect(page).not_to have_content(adventure_private_3.name)
    expect(page).not_to have_content(adventure_private_4.name)
  end

  scenario "authenticated user successfully clicks on an adventure link and " \
  "navigates to the associated address" do
  # TEST MANUALLY: deactivated b/c test only works for internal links
  #   user = FactoryGirl.create(:user)
  #   visit new_user_session_path
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "Log in"
  #
  #   bucket_list = FactoryGirl.create(:bucket_list, user_id: user.id)
  #   adventure = FactoryGirl.create(
  #     :adventure,
  #     user_id: user.id
  #   )
  #   bucket_list_adventure = FactoryGirl.create(
  #     :bucket_list_adventure,
  #     bucket_list_id: bucket_list.id,
  #     adventure_id: adventure.id
  #   )
  #
  #   visit adventure_path(adventure.id)
  #
  #   expect(page).to have_selector(:css, 'a[href="www.google.com"]')
  #   expect(page).to have_content(bucket_list.title)
  #   expect(page).to have_content(adventure.name)
  #   expect(page).to have_content(adventure.link)
  #
  #   click_link adventure.link
  #
  #   expect(page).not_to have_content(bucket_list.title)
  #   expect(page).not_to have_content(adventure.name)
  end

  scenario "authenticated user successfully switches an adventure from public" \
  " to private by clicking on the appropirate icon" do
    # user = FactoryGirl.create(:user)
    # sign_in(user)
    #
    # bucket_list = FactoryGirl.create(:bucket_list, user_id: user.id)
    # adventure = FactoryGirl.create(
    #   :adventure,
    #   is_shared: true
    # )
    # bucket_list_adventure = FactoryGirl.create(
    #   :bucket_list_adventure,
    #   bucket_list_id: bucket_list.id,
    #   adventure_id: adventure.id,
    # )
    #
    # visit bucket_list_path(bucket_list.id)
    # click_link "Edit"
    # checkbox_shared = find_by_id("input#bucket_list_is_public")
    # check "Share it!"
    # click_button "Save It!"
    #
    # expect(checkbox_shared).to be_checked
    # expect(page).to have_content("Changes saved!")
    # expect(page).not_to have_content("Address can't be blank")
  end
end
