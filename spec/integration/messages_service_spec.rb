require 'swagger_helper'
describe 'Messages', type: :request do

  path '/message' do
    post 'Create Message' do
      tags 'Message'
      consumes 'application/json'

      parameter name: :params, in: :body, schema: {
        properties: {
          author: { type: :string },
          message: { type: :string }
        }
      }

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 status_code: { type: :integer },
                 message: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     author: { type: :string },
                     message: { type: :string },
                     created_at: { type: :string }
                   }
                 }
               }
        let(:params) { { author: 'Ruby', message: 'Hello World' } }
        run_test!
      end

      response '400', 'Bad request' do
        schema type: :object,
               properties: {
                 status_code: { type: :integer },
                 error_msg: { type: :string }
               }
        let(:params) { { author: nil, message: nil } }
        run_test!
      end
    end
  end

  path '/message/{message_id}/like' do
    post 'Like Message' do
      tags 'Message'
      consumes 'application/json'

      parameter name: :message_id, in: :path

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 status_code: { type: :integer },
                 like: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     ip_address: { type: :string },
                     message_id: { type: :integer }
                   }
                 }
               }
        before do
          @message = Message.create(author: "Ruby", message: "Hello World")
        end

        let(:message_id) { @message.id }
        run_test!
      end

      response '400', 'Bad request' do
        schema type: :object,
               properties: {
                 status_code: { type: :integer },
                 error_msg: { type: :string }
               }
        before do
          @message = Message.create(author: "Ruby", message: "Hello World")
        end

        let(:message_id) { @message.id + 1}
        run_test!
      end
    end
  end

  path '/top_messages/{period}' do
    get 'Get Top Five Message Of Period' do
      tags 'Message'
      consumes 'application/json'

      parameter name: :period, in: :path

      response '200', 'OK' do
        schema type: :object,
               properties: {
                 status_code: { type: :integer },
                 messages: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       author: { type: :string },
                       message: { type: :string },
                       created_at: { type: :string }
                     }
                   }
                 }
               }
        before do
          @message = Message.create(author: "Ruby", message: "Hello World")
        end

        let(:period) { "week" }
        run_test!
      end
    end
  end
end
