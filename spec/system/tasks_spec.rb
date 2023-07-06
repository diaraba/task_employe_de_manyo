require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe 'Fonction d\'enregistrement' do

    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_session_path

      fill_in "session_email", with: "ashborn@gmail.com"
      fill_in "session_password", with: "123456"
      click_button "Log in"
    end


    context 'Lors de l\'enregistrement d\'une tâche' do
      it 'La tâche enregistrée s\'affiche' do
        @task=FactoryBot.create(:task, title: 'Enquête concurrentielle', content: 'Enquêter sur les services d\'autres entreprises.', user: user)
        visit tasks_path
        expect(page).to have_content("Enquête concurrentielle")
      end
    end
  end



  describe 'Fonction d\'affichage de liste' do

    let!(:user) { FactoryBot.create(:user) }

    # Les données de test peuvent être partagées par plusieurs tests en définissant les données de test comme des variables à l'aide de let !
    let!(:task1) { FactoryBot.create(:task, title: 'first_task_title', user: user) }
    let!(:task2) { FactoryBot.create(:second_task, title: 'second_task_title', user: user) }
    let!(:task3) { FactoryBot.create(:third_task, title: 'third_task_title', user: user) }
    # Le code avant est exécuté au moment où le contexte est exécuté, comme "lors du passage à l'écran de liste" ou "lorsque les tâches sont organisées par ordre décroissant de date de création".
    before do
      visit new_session_path
  
      fill_in "session_email", with: "ashborn@gmail.com"
      fill_in "session_password", with: "123456"
      click_button "Log in"

      visit tasks_path

      # Si le résultat de expect est "true", le résultat du test est affiché comme un succès, et si le résultat de expect est "false", le résultat du test est affiché comme un échec.
      task_list = all('body tr')
        
      expect(task_list[1]).to have_text(task1.title)
      expect(task_list[2]).to have_text(task2.title)
      expect(task_list[3]).to have_content(task3.title)
    end

    context "Lors de la transition vers l'écran de liste" do
      it "Une liste des tâches enregistrées s'affiche" do
        # Attendez (confirmez / attendez) que la chaîne de caractères "création de document" soit incluse dans la page visitée (dans ce cas, l'écran de la liste des tâches).
        expect(page).to have_content 'task'
      end
    end

    context 'Si une nouvelle tâche est créée' do
      it 'La nouvelle tâche s\'affiche en haut' do
        task_list = all('body tr')
        expect(task_list[1]).to have_text(task1.title)
      end
    end
    #Implementation du test des differents tri et  recherche
    
    describe 'fonction de tri' do
      context 'Si vous cliquez sur le lien "Expire"' do
        it "Une liste de tâches triées par ordre croissant de date d'échéance s'affiche." do
          # Utilisez la méthode all pour vérifier l'ordre de plusieurs données de test.
          click_link 'expiration date'
          visit current_url
          
          task_list = all('body tr')


          expect(task_list[1]).to have_text(task3.title)
          expect(task_list[2]).to have_text(task2.title)
          expect(task_list[3]).to have_text(task1.title)
        end
      end
      context "Si vous cliquez sur le lien Priorité." do
        it "Une liste de tâches triées par priorité s'affiche." do
          click_link 'priority'
          visit current_url
          task_list = all('body tr')


          expect(task_list[1]).to have_content(task2.title)
        end
      end
    end
    describe 'Fonction de recherche' do
      context 'Si vous effectuez une recherche floue par Title' do
        it "Seules les tâches contenant des termes de recherche sont affichées." do
          fill_in "title", with: "first"
          #byebug  
          click_button "Rechercher"
          task_list = all('body tbody tr')
          #byebug  
          expect(task_list.count).to eq 1
          expect(task_list.first).to have_content "first_task"
          expect(task_list.first).not_to have_content "second_task"
          expect(task_list.first).not_to have_content "third_task"
        end
      end
      context 'Recherche par statut.' do
        it "Seules les tâches correspondant à l'état recherché sont affichées." do
          select "Terminé", from: "search[status]"
          click_button "Rechercher"
          task_list = all('body tbody tr')

          expect(task_list.count).to eq 1
          expect(task_list.first).not_to have_content "first_task"
          expect(task_list.first).not_to have_content "second_task"
          expect(task_list.first).to have_content "third_task"
        end
      end
      context 'Title et rechercher par statut' do
        it "Seules les tâches qui contiennent le mot de recherche Title et qui correspondent au statut seront affichées." do
          fill_in "title", with: "first_task"
          select "Non_démarré", from: "search[status]"
          click_button "Rechercher"
          task_list = all('body tbody tr')

          expect(task_list.count).to eq 1
          expect(task_list.first).to have_content "first_task"
          expect(task_list.first).not_to have_content "second_task"
          expect(task_list.first).not_to have_content "third_task"
        end
      end
    end





  end

  describe 'Fonction d\'affichage détaillée' do

     
    let!(:user) { FactoryBot.create(:user) }
     before do
        visit new_session_path

        fill_in "session_email", with: "ashborn@gmail.com"
        fill_in "session_password", with: "123456"
        click_button "Log in"
     end
 


     context 'Lors de la transition vers un écran de détails de tâche' do
       it 'Le contenu de la tâche s\'affiche' do
        # Enregistrer une tâche à utiliser dans le test
        @task=FactoryBot.create(:second_task, title: 'Enquête concurrentielle', content: 'Enquêter sur les services d\'autres entreprises.', user: user)

        # Passer à l'écran de la liste des tâches
        click_link "Liste des utilisateurs"
        click_on 'Montrer', match: :first
        # Attendez (confirmez / attendez) que la chaîne de caractères "création de document" soit incluse dans la page visitée (dans ce cas, l'écran de la liste des tâches).
        expect(page).to have_content 'Enquête concurrentielle'
        # Si le résultat de expect est "true", le résultat du test est affiché comme un succès, et si le résultat de expect est "false", le résultat du test est affiché comme un échec.
      
       end
     end
  end
end
