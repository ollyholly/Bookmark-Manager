feature 'View bookmarks' do
  scenario 'can view a list of bookmarks' do
    visit('/bookmarks')
    expect(page).to have_content 'Bookmarks'
    expect(page).to have_content 'http://google.com'
    expect(page).to have_content 'http://facebook.com'
  end
end