class ListsPage
  include CommonPageObject

  def go_to_collection
    click_on I18n.t('layouts.app_header.my_collection')
  end

  def t(key)
    I18n.t("#{key}")
  end
end
