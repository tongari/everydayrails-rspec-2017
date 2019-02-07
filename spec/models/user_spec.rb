require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 姓、名、メール、パスワードがあれば有効な状態であること
  it 'is valid with a first name, last name, email, and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること
  it { is_expected.to validate_presence_of :first_name }

  # it 'is invalid without a first name' do
  #   # user = User.new first_name: nil
  #   user = FactoryBot.build(:user, first_name: nil)
  #   user.valid?
  #   expect(user.errors[:first_name]).to include "can't be blank"
  #   # 失敗させるexample
  #   # expect(user.errors[:first_name]).to_not include "can't be blank"
  #   # be_falseyマッチャーで検証
  #   # expect(user[:first_name]).to be_falsey
  # end

  # 姓がなければ無効な状態であること
  it { is_expected.to validate_presence_of :last_name }

  # it 'is invalid without a last name' do
  #   # user = User.new last_name: nil
  #   user = FactoryBot.build(:user, last_name: nil)
  #   user.valid?
  #   expect(user.errors[:last_name]).to include "can't be blank"
  # end

  # メールアドレスがなければ無効な状態であること
  it { is_expected.to validate_presence_of :email }

  # it 'is invalid without an email address' do
  #   # user = User.new email: nil
  #   user = FactoryBot.build(:user, email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include "can't be blank"
  # end

  # 重複したメールアドレスなら無効な状態であること
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  # it 'is invalid with a duplicate email address' do
  #   FactoryBot.create(:user,  email: 'hoge@gmail.com')
  #   user = FactoryBot.build(:user, email: 'hoge@gmail.com')
  #   user.valid?
  #   expect(user.errors[:email]).to include 'has already been taken'
  #   # expect(user).to_not be_valid
  # end

  # ユーザのフルネームを文字列として返すこと
  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: 'hoge', last_name: 'huga')
    expect(user.name).to eq 'hoge huga'
  end

  # 複数のユーザーで何かする
  it 'does something with multiple users' do
    user_1 = FactoryBot.create(:user)
    user_2 = FactoryBot.create(:user)
    expect(true).to be_truthy
  end

  # アカウントが作成されたときにウェルカムメールを送信すること
  it 'sends a welcome email on account creation' do
    allow(UserMailer).to receive_message_chain(:welcome_email, :deliver_later)
    user = FactoryBot.create(:user)
    expect(UserMailer).to have_received(:welcome_email).with(user)
  end

  # ジオコーディングを実行すること
  it 'performs geocoding', vcr: true do
    user = FactoryBot.create(:user, last_sign_in_ip: '161.185.207.20')
    expect {
      user.geocode
    }.to change(user, :location).from(nil).to('Brooklyn, New York, US')
  end
end
