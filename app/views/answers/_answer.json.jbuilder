json.extract! answer, :id, :user_id, :question_id, :description, :created_at, :updated_at
json.url answer_url(answer, format: :json)
