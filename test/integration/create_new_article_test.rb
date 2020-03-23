require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'John', email: 'john@doe.com', password: 'password', admin: true)
  end

  test 'get new article form and create article' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'example', description: 'this is an example descr.' } }
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_match 'example', response.body
  end
end
