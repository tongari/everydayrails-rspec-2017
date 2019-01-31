require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # pending "add some examples to (or delete) #{__FILE__}"
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it 'is valid with a first name, last name, email, and password' do
    # user = User.new(
    #              first_name: 'Tongari',
    #              last_name: 'Saito',
    #              email: 'hoge@gmail.com',
    #              password: 'hogehoge',
    # )
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること
  it 'is invalid without a first name' do
    # user = User.new first_name: nil
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include "can't be blank"
    # 失敗させるexample
    # expect(user.errors[:first_name]).to_not include "can't be blank"
    # be_falseyマッチャーで検証
    # expect(user[:first_name]).to be_falsey
  end

  # 姓がなければ無効な状態であること
  it 'is invalid without a last name' do
    # user = User.new last_name: nil
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include "can't be blank"
  end

  # メールアドレスがなければ無効な状態であること
  it 'is invalid without an email address' do
    # user = User.new email: nil
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include "can't be blank"
  end

  # 重複したメールアドレスなら無効な状態であること
  it 'is invalid with a duplicate email address' do
    # User.create(
    #   first_name: 'Hoge',
    #   last_name: 'Saito',
    #   email: 'hoge@gmail.com',
    #   password: 'hogehoge'
    # )
    FactoryBot.create(:user,  email: 'hoge@gmail.com')

    # user = User.new(
    #   first_name: 'Hoge',
    #   last_name: 'Saito',
    #   email: 'hoge@gmail.com',
    #   password: 'hogehoge'
    # )

    user = FactoryBot.build(:user, email: 'hoge@gmail.com')

    user.valid?
    expect(user.errors[:email]).to include 'has already been taken'
    # expect(user).to_not be_valid
  end

  # ユーザのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    # user = User.new(
    #              first_name: 'hoge',
    #              last_name: 'huga',
    #              email: 'hoge@gmail.com'
    # )
    user = FactoryBot.build(:user, first_name: 'hoge', last_name: 'huga')
    expect(user.name).to eq 'hoge huga'
  end

  # 複数のユーザーで何かする
  it 'does something with multiple users' do
    user_1 = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:user)
    expect(true).to be_truthy
  end

end
