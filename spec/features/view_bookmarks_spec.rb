feature 'View bookmarks' do
  scenario 'can view a list of bookmarks' do
    visit('/bookmarks')
    expect(page).to have_content 'Bookmarks'
    expect(page).to have_content 'http://www.google.com'
    expect(page).to have_content 'http://www.twitter.com'
  end
end