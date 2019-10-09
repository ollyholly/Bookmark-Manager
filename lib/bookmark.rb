require_relative 'database_connection'

class Bookmark

  def self.all
    bookmarks = DatabaseConnection.query('SELECT * FROM bookmarks;')
    bookmarks.map do |bookmark|
      Bookmark.new(
        url: bookmark['url'],
        title: bookmark['title'],
        id: bookmark['id']
      )
    end
  end

  def self.create(url:, title:)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(
      url: result[0]['url'],
      title: result[0]['title'],
      id: result[0]['id']
    )
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id} RETURNING id, url, title;")
    Bookmark.new(
      url: result[0]['url'],
      title: result[0]['title'],
      id: result[0]['id']
    )
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(
      url: result[0]['url'],
      title: result[0]['title'], 
      id: result[0]['id']
    )
  end

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end