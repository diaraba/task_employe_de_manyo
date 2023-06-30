require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe 'Fonction d\'enregistrement' do
    context 'Lors de l\'enregistrement d\'une tâche' do
      it 'La tâche enregistrée s\'affiche' do
        visit new_task_path
        fill_in "Title", with:"RubyBook Course"
        fill_in "Content", with:"6 Modules pour terminer ce cours"
        click_button "Create Task"
        visit tasks_path
        expect(page).to have_content("6 Modules pour terminer ce cours")
      end
    end
  end

  describe 'Fonction d\'affichage de liste' do
    context 'Lors de la transition vers l\'écran de liste' do
      it 'Une liste des tâches enregistrées s\'affiche' do
        # Enregistrer une tâche à utiliser dans le test
        FactoryBot.create(:task)
        # Passer à l'écran de la liste des tâches
        visit tasks_path
        # Attendez (confirmez / attendez) que la chaîne de caractères "création de document" soit incluse dans la page visitée (dans ce cas, l'écran de la liste des tâches).
        expect(page).to have_content 'Préparation des documents'
        # Si le résultat de expect est "true", le résultat du test est affiché comme un succès, et si le résultat de expect est "false", le résultat du test est affiché comme un échec.
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
        expect(page).to have_content 'Page de détails de la tâche'
        # Si le résultat de expect est "true", le résultat du test est affiché comme un succès, et si le résultat de expect est "false", le résultat du test est affiché comme un échec.
      
       end
     end
  end
end
