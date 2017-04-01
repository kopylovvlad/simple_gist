require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe 'user' do
    let(:user) do
      FactoryGirl.create(:user)
    end
    let(:another_user) do
      FactoryGirl.create(:user)
    end
    let(:user_gist) do
      FactoryGirl.create(
        :gist,
        user_id: user.id
      )
    end
    let(:another_gist) do
      FactoryGirl.create(
        :gist,
        user_id: another_user.id
      )
    end

    describe 'for own gist' do
      it 'can create own comment' do
        sign_in user
        post(
          gist_comments_path(user_gist),
          params: {
            comment: {
              body: 'my own comment body',
              user_id: user.id
            }
          }
        )

        expect(response.code).to eq('302')
        expect(response).to redirect_to(gist_path(user_gist))
        follow_redirect!
        expect(response.code).to eq('200')

        created_comment = Comment.find_by(
          body: 'my own comment body',
          user_id: user.id,
          gist_id: user_gist.id
        )
        expect(created_comment).to_not eq(nil)
      end

      it 'can destroy own comment' do
        comment = FactoryGirl.create(
          :comment,
          user_id: user.id,
          gist_id: user_gist.id
        )
        sign_in user
        delete(gist_comment_path(user_gist, comment))

        expect(response.code).to eq('302')
        expect(response).to redirect_to(gist_path(user_gist))
        follow_redirect!
        expect(response.code).to eq('200')
        expect(Comment.find_by(id: comment.id)).to eq(nil)
      end

      it 'can not destroy another comment' do
        comment = FactoryGirl.create(
          :comment,
          user_id: another_user.id,
          gist_id: user_gist.id
        )
        sign_in user
        delete(gist_comment_path(user_gist, comment))

        expect(response.code).to eq('500')
        expect(Comment.find_by(id: comment.id)).to_not eq(nil)
      end
    end

    describe 'for another gist' do
      it 'can create own comment' do
        sign_in user
        post(
          gist_comments_path(another_gist),
          params: {
            comment: {
              body: 'my own comment body',
              user_id: user.id
            }
          }
        )

        expect(response.code).to eq('302')
        expect(response).to redirect_to(gist_path(another_gist))
        follow_redirect!
        expect(response.code).to eq('200')

        created_comment = Comment.find_by(
          body: 'my own comment body',
          user_id: user.id,
          gist_id: another_gist.id
        )
        expect(created_comment).to_not eq(nil)
      end

      it 'can destroy own comment' do
        comment = FactoryGirl.create(
          :comment,
          user_id: user.id,
          gist_id: another_gist.id
        )
        sign_in user
        delete(gist_comment_path(another_gist, comment))

        expect(response.code).to eq('302')
        expect(response).to redirect_to(gist_path(another_gist))
        follow_redirect!
        expect(response.code).to eq('200')
        expect(Comment.find_by(id: comment.id)).to eq(nil)
      end

      it 'can not destroy another comment' do
        comment = FactoryGirl.create(
          :comment,
          user_id: another_user.id,
          gist_id: another_gist.id
        )
        sign_in user
        delete(gist_comment_path(another_gist, comment))

        expect(response.code).to eq('500')
        expect(Comment.find_by(id: comment.id)).to_not eq(nil)
      end
    end
  end

  describe 'guest' do
    describe 'for existing gist' do
      let(:anoter_user) do
        FactoryGirl.create(:user)
      end
      let(:gist) do
        FactoryGirl.create(
          :gist,
          user_id: anoter_user.id
        )
      end
      let(:another_comment) do
        FactoryGirl.create(
          :comment,
          user_id: anoter_user.id,
          gist_id: gist.id
        )
      end

      it 'can not create comment' do
        post(
          gist_comments_path(gist),
          params: {
            comment: {
              body: 'comment body'
            }
          }
        )
        expect(response.code).to eq('500')
      end

      it 'can not destroy another comment' do
        delete(gist_comment_path(gist, another_comment))
        expect(response.code).to eq('500')
        expect(Comment.find_by(id: another_comment.id)).to_not eq(nil)
      end
    end
  end
end
