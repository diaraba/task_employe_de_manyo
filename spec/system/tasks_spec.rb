require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe 'Fonction d\'enregistrement' do
    context 'Lors de l\'enregistrement d\'une tâche' do
      it 'La tâche enregistrée s\'affiche' do
        visit new_task_path
        fill_in "Titre", with:"RubyBook Course"
        fill_in "Contenu", with:"6 Modules pour terminer ce cours"
        click_button "Créer"
        visit tasks_path
        expect(page).to have_content("6 Modules pour terminer ce cours")
      end
    end
  end

  describe 'Fonction d\'affichage de liste' do
    # Les données de test peuvent être partagées par plusieurs tests en définissant les données de test comme des variables à l'aide de let !
    let!(:task1) { FactoryBot.create(:task, title: 'task_title') }
    let!(:task2) { FactoryBot.create(:second_task, title: 'second_task_title') }
    let!(:task3) { FactoryBot.create(:third_task, title: 'third_task_title') }
    # Le code avant est exécuté au moment où le contexte est exécuté, comme "lors du passage à l'écran de liste" ou "lorsque les tâches sont organisées par ordre décroissant de date de création".
    before do
      visit tasks_path

      # Si le résultat de expect est "true", le résultat du test est affiché comme un succès, et si le résultat de expect est "false", le résultat du test est affiché comme un échec.
      task_list = all('body tr')
        
      expect(task_list[1]).to have_text(task3.title)
      expect(task_list[2]).to have_text(task2.title)
      expect(task_list[3]).to have_content(task1.title)

    end

    context "Lors de la transition vers l'écran de liste" do
      it "Une liste des tâches enregistrées s'affiche" do
        # Attendez (confirmez / attendez) que la chaîne de caractères "création de document" soit incluse dans la page visitée (dans ce cas, l'écran de la liste des tâches).
        expect(page).to have_content 'task_title'
      end
    end

    context 'Si une nouvelle tâche est créée' do
      it 'La nouvelle tâche s\'affiche en haut' do
        task_list = all('body tr')
        expect(task_list[1]).to have_text(task3.title)
      end
    end
  end

  describe 'Fonction d\'affichage détaillée' do
     context 'Lors de la transition vers un écran de détails de tâche' do
       it 'Le contenu de la tâche s\'affiche' do
        # Enregistrer une tâche à utiliser dans le test
        @task=FactoryBot.create(:second_task, title: 'Enquête concurrentielle', content: 'Enquêter sur les services d\'autres entreprises.')

        # Passer à l'écran de la liste des tâches
        visit task_path(@task)
        # Attendez (confirmez / attendez) que la chaîne de caractères "création de document" soit incluse dans la page visitée (dans ce cas, l'écran de la liste des tâches).
        expect(page).to have_content 'Page des détails de la tâche'
        # Si le résultat de expect est "true", le résultat du test est affiché comme un succès, et si le résultat de expect est "false", le résultat du test est affiché comme un échec.
      
       end
     end
  end
end
