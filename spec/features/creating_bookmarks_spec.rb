feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.facebook.com')
    fill_in('title', with: 'Facebook')
    click_button 'Submit'

    expect(page).to have_link('Facebook', href: 'http://www.facebook.com')
  end
end