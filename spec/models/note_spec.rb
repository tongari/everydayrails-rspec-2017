require 'rails_helper'

RSpec.describe Note, type: :model do

  # before do
  #   # @user = User.create(
  #   #   first_name: 'hoge',
  #   #   last_name: 'huga',
  #   #   email: 'hoge@gmail.com',
  #   #   password: 'hogehoge'
  #   # )
  #
  #   @user = FactoryBot.create(:user)
  #   @project = @user.projects.create name: 'Test Project'
  # end

  # ファクトリで関連するデータを生成する
  it 'generates associated data from a factory' do
    note = FactoryBot.build(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end

  # ユーザ、プロジェクト、メッセージがあれば有効な状態であること
  it 'is valid with a user, project, and message' do
    # note = Note.new(
    #   message: 'This is a simple note.',
    #   user: @user,
    #   project: @project
    # )
    note = FactoryBot.build(:note)
    expect(note).to be_valid
  end

  # メッセージがなければ無効な状態であること
  it 'is invalid without a message' do
    # note = Note.new message:nil
    note = FactoryBot.build(:note, message: nil)
    note.valid?
    expect(note.errors[:message]).to include "can't be blank"
  end

  # 文字列に一致するメッセージを検索する
  describe 'search message for a term' do
    before do
      # @note1 = @project.notes.create(
      #   message: 'This is the first note.',
      #   user: @user
      # )
      #
      # @note2 = @project.notes.create(
      #   message: 'This is the second note.',
      #   user: @user
      # )
      # @note3 = @project.notes.create(
      #   message: 'First, preheat the oven.',
      #   user: @user
      # )

      @note_1 = FactoryBot.create(:note, message: 'This is the first note.')
      @note_2 = FactoryBot.create(:note, message: 'This is the second note.')
      @note_3 = FactoryBot.create(:note, message: 'First, preheat the oven.')
    end

    # 一致するデータが見つかるとき
    context 'when a match is found' do
      # 検索文字列に一致するメモを返すこと
      it 'returns notes that match the search term' do
        expect(Note.search('first')).to include(@note_1, @note_3)
      end
    end

    # 一致するデータが1件も見つからないとき
    context 'when no match is found' do
      # 空のコレクションを返すこと
      it 'returns an empty collection' do
        expect(Note.search('message')).to be_empty
      end
    end
  end
end
