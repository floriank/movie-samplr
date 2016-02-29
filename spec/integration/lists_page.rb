class ListsPage
  include CommonPageObject

  def go_to_collection
    visit lists_path
  end

  def rename_default_list(name)
    first('.rename-link').click
    fill_in 'list[name]', with: name
    click_on t('edit.submit')
  end

  def t(key)
    I18n.t("lists.#{key}")
  end
end
