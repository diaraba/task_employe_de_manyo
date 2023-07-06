require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Fonction de recherche' do
    # Créez des données de test multiples.
    let!(:user) { FactoryBot.create(:user) }
    let!(:task1) { FactoryBot.create(:task, title: 'first_task_title', user: user) }
    let!(:task2) { FactoryBot.create(:second_task, title: 'second_task_title', user: user) }
    let!(:task3) { FactoryBot.create(:third_task, title: 'third_task_title', user: user) }
    context "Lorsqu'une recherche ambiguë d'un Title la méthode scope" do
      it "Les tâches contenant des termes de recherche sont réduites." do
        # Title Exemple de code pour une méthode de recherche définie dans la portée comme search_title dans
        # Insérer des mots de recherche dans les méthodes de recherche définies à l'aide de la portée.
        # Utilisez les matrices to et not_to pour vérifier à la fois ce qui est recherché et ce qui ne l'est pas.
        # Vérifiez le nombre de données de test récupérées.
        expect(Task.search_title('first')).to include(task1)
        expect(Task.search_title('first')).not_to include(task2)
        expect(Task.search_title('first')).not_to include(task3)
        expect(Task.search_title('first').count).to eq 1
      end
    end
    
    context "Lorsque l'état est recherché avec la méthode scope" do
      it "Les tâches qui correspondent exactement au statut sont réduites" do
        # Title Exemple de code pour une méthode de recherche définie dans la portée comme search_title dans
        # Insérer des mots de recherche dans les méthodes de recherche définies à l'aide de la portée.
        # Utilisez les matrices to et not_to pour vérifier à la fois ce qui est recherché et ce qui ne l'est pas.
        # Vérifiez le nombre de données de test récupérées.
        expect(Task.search_status('Non_démarré').search_title('first')).to include(task1)
        expect(Task.search_status('Non_démarré').search_title('first')).not_to include(task2)
        expect(Task.search_status('Non_démarré').search_title('first')).not_to include(task3)
        expect(Task.search_status('Non_démarré').count).to eq 1
      end
    end

    context "Lors de l'exécution d'une recherche floue et d'une recherche d'état Title" do
      it "Les tâches qui correspondent exactement au statut sont réduites" do
        expect(Task.search_status('Terminé')).not_to include(task1)
        expect(Task.search_status('Terminé')).not_to include(task2)
        expect(Task.search_status('Terminé')).to include(task3)
        expect(Task.search_status('Terminé').count).to eq 1
      end
    end

  end
end
