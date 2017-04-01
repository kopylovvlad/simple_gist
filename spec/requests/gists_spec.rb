require 'rails_helper'

RSpec.describe 'Gists', type: :request do
  describe 'CRUD' do
    describe 'for auth user' do
      let(:user) do
        FactoryGirl.create(:user)
      end
      let(:user_gist) do
        FactoryGirl.create(
          :gist,
          user_id: user.id
        )
      end
      let(:another_user_gist) do
        FactoryGirl.create(
          :gist,
          user_id: FactoryGirl.create(:user).id
        )
      end

      it 'can listing' do
        sign_in user
        get gists_path
        expect(response.code).to eq('200')
      end

      it 'can start create new gist' do
        sign_in user
        get new_gist_path
        expect(response.code).to eq('200')
      end

      it 'can create new gist' do
        expect(Gist.find_by(title: 'test_hello.rb', lang_mode: 'ruby')).to eq(nil)
        sign_in user
        post(
          gists_path,
          params: {
            gist: {
              title: 'test_hello.rb',
              body: "puts('hello');",
              lang_mode: 'ruby',
              user_id: user.id
            }
          }
        )
        expect(response.code).to eq('302')
        follow_redirect!
        expect(response.code).to eq('200')
        created_gist = Gist.find_by(title: 'test_hello.rb', lang_mode: 'ruby')
        expect(created_gist).to_not eq(nil)
      end

      it 'can show own gist' do
        sign_in user
        get gist_path(user_gist)
        expect(response.code).to eq('200')
      end

      it 'can show another gist' do
        sign_in user
        get gist_path(another_user_gist)
        expect(response.code).to eq('200')
        expect(another_user_gist.user_id).to_not eq(user.id)
      end

      it 'can edit own gist' do
        sign_in user
        get edit_gist_path(user_gist)
        expect(response.code).to eq('200')
      end

      it 'can not edit another gist' do
        sign_in user
        get edit_gist_path(another_user_gist)
        expect(response.code).to eq('500')
      end

      it 'can update own gist' do
        sign_in user
        patch(
          gist_path(user_gist),
          params: {
            gist: {
              title: 'foo.cpp',
              body: 'include stdio',
              lang_mode: 'cpp'
            }
          }
        )
        expect(response.code).to eq('302')
        expect(response).to redirect_to(gist_path(user_gist))
        follow_redirect!
        expect(response.code).to eq('200')

        updated_gist = Gist.find_by(id: user_gist.id)
        expect(updated_gist).to_not eq(nil)
        expect(updated_gist.title).to eq('foo.cpp')
        expect(updated_gist.body).to eq('include stdio')
        expect(updated_gist.lang_mode).to eq('cpp')
      end

      it 'can not update another gist' do
        sign_in user
        patch(
          gist_path(another_user_gist),
          params: {
            gist: {
              title: 'foo.cpp',
              body: 'include stdio',
              lang_mode: 'cpp'
            }
          }
        )
        expect(response.code).to eq('500')
        updated_gist = Gist.find_by(id: user_gist.id)
        expect(updated_gist).to_not eq(nil)
        expect(updated_gist.title).to_not eq('foo.cpp')
        expect(updated_gist.body).to_not eq('include stdio')
        expect(updated_gist.lang_mode).to_not eq('cpp')
      end

      it 'can destroy own gist' do
        sign_in user
        delete(gist_path(user_gist))

        expect(response.code).to eq('302')
        expect(response).to redirect_to(user_path(user_login: user.login))
        follow_redirect!
        expect(response.code).to eq('200')

        expect(Gist.find_by(id: user_gist.id)).to eq(nil)
      end

      it 'can not destroy another gist' do
        sign_in user
        delete(gist_path(another_user_gist))
        expect(response.code).to eq('500')
        expect(Gist.find_by(id: another_user_gist.id)).to_not eq(nil)
      end
    end

    describe 'for guest' do
      let(:created_gist) do
        FactoryGirl.create(
          :gist,
          user_id: FactoryGirl.create(:user).id
        )
      end

      it 'can listing' do
        get gists_path
        expect(response.code).to eq('200')
      end

      it 'can not start create new gist' do
        get new_gist_path
        expect(response.code).to eq('500')
      end

      it 'can not create new gist' do
        post(
          gists_path,
          params: {
            gist: {
              title: 'hello.rb',
              body: 'hello',
              lang_mode: 'hello',
              user_id: 1
            }
          }
        )
        expect(response.code).to eq('500')
      end

      it 'can show another gist' do
        get gist_path(created_gist)
        expect(response.code).to eq('200')
      end

      it 'can not edit gist' do
        get edit_gist_path(created_gist)
        expect(response.code).to eq('500')
      end

      it 'can not update gist' do
        patch(
          gist_path(created_gist),
          params: {
            gist: {
              title: 'another_hello.rb',
              body: '#another_hello',
              lang_mode: 'javascript',
              user_id: 1
            }
          }
        )
        expect(response.code).to eq('500')
        gist = Gist.find_by(id: created_gist.id)
        expect(gist).to_not eq(nil)
        expect(gist.title).to_not eq('another_hello.rb')
        expect(gist.body).to_not eq('#another_hello')
        expect(gist.lang_mode).to_not eq('javascript')
      end

      it 'can not destroy gist' do
        delete(gist_path(created_gist))
        expect(response.code).to eq('500')
        gist = Gist.find_by(id: created_gist.id)
        expect(gist).to_not eq(nil)
      end
    end
  end
end
