# a page object to unify the handling of the splash page
class SplashPage
  include Capybara::DSL

  def initialize
    visit '/'
  end

  def search_box
    find('input#movie')
  end

  def collection_link
    find('a#collection-link')
  end

  def t(key, opts = {})
    I18n.t("home.index.#{key}", opts)
  end
end
