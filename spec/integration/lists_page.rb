class ListsPage
  include CommonPageObject

  def go_to_collection
    visit lists_path
  end

  def rename_default_list(name)
    first('.rename-link').click
    fill_in 'list[name]', with: name
    click_on t('form.submit')
  end

  def create_new_list(name)
    click_on t('index.create')
    fill_in 'list_name', with: name
    click_on t('form.submit')
  end

  def remove_first_custom_list
    first('.delete-link').click
  end

  def show_more
    first('.movie.more > a').click
  end

  def t(key)
    I18n.t("lists.#{key}")
  end
end
