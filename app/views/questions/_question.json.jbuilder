json.extract! question, :id, :text, :op1, :op2, :op3, :op4, :answer, :subgenre_id, :created_at, :updated_at
json.url question_url(question, format: :json)
