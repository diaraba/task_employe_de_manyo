# La mention "Utiliser FactoryBot"
FactoryBot.define do
    # Nommez les données de test à créer "tâche"
    # 「task」のように存在するクラス名のスネークケースをテストデータ名とする場合、そのクラスのテストデータが作成されます
    factory :task do
      user
      title { 'first_task' }
      content { 'Créer une proposition.' }
      created_at { '2025-02-18' }
      deadline_on {'2025-02-18'}
      priority {'Moyenne'}
      status {'Non_démarré'}
    end
    # Nommez les données de test à créer "second_task"
    # 「second_task」のように存在しないクラス名のスネークケースをテストデータ名とする場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要があります
    factory :second_task, class: Task do
      user
      title { 'second_task' }
      content { 'Envoyer un e-mail de vente à un client.' }
      created_at { '2025-02-17' }
      deadline_on {'2025-02-17'}
      priority {'Elevee'}
      status {'Démarré'}
    end

    factory :third_task, class: Task do
      user
      title { 'third_task' }
      content { 'Checkout how work ordered task.' }
      created_at { '2025-02-16' }
      deadline_on {'2025-02-16'}
      priority {'Faible'}
      status {'Terminé'}
    end
end