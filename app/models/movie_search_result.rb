class MovieSearchResult
  attr_accessor :title, :id, :type, :synopsis

  def initialize(title:, id:, type: 'local', synopsis: nil)
    @title = title
    @id = id
    @type = type
    @synopsis = synopsis
  end

  def imdb?
    type == 'imdb'
  end

  def local?
    !imdb?
  end
end
