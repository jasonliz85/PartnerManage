PartnerManager::Application.routes.draw do
	root :to => "calendar#index"
	
	match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
	match '/bridges(/:year(/:month(/:day)))' => 'bridges#index', :as => :bridges, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/}
	#match '/shift_templates(/:year(/:month))' => 'shift_templates#index', :as => :shift_templates, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
	#match '/shifts(/:year(/:month))' => 'shifts#index', :as => :shifts, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
	#match 'partner/partner_id/update_shift' => 'work_plan#update_shift', :as => :update_shift
	
	resources :partners do 
		resource :work_plan do
			get 'workplanwizard', :on => :member
			get 'populate', :on => :member
			put 'update_shifts', :on => :member
			put 'wizardworkplanupdate', :on => :member
			resources :weekly_rotas
		end
		resources :holidays do
			get 'holidaywizard', :on => :member
		end
		resource :contact, :only => [:edit, :update]
		resources :shifts
		resource :competency, :only => [:edit, :update] do
			get 'competencywizard', :on => :member
			put 'wizardcompetencyupdate', :on => :member
		end
		end
end


#== Route Map
# Generated on 24 Feb 2011 14:52
#
#                                      root        /(.:format)                                                       {:controller=>"calendar", :action=>"index"}
#                                  calendar        /calendar(/:year(/:month))(.:format)                              {:year=>/\d{4}/, :month=>/\d{1,2}/, :controller=>"calendar", :action=>"index"}
#                                   bridges        /bridges(/:year(/:month(/:day)))(.:format)                        {:year=>/\d{4}/, :month=>/\d{1,2}/, :day=>/\d{1,2}/, :controller=>"bridges", :action=>"index"}
#          workplanwizard_partner_work_plan GET    /partners/:partner_id/work_plan/workplanwizard(.:format)          {:action=>"workplanwizard", :controller=>"work_plans"}
#                populate_partner_work_plan GET    /partners/:partner_id/work_plan/populate(.:format)                {:action=>"populate", :controller=>"work_plans"}
#           update_shifts_partner_work_plan PUT    /partners/:partner_id/work_plan/update_shifts(.:format)           {:action=>"update_shifts", :controller=>"work_plans"}
#    wizardworkplanupdate_partner_work_plan PUT    /partners/:partner_id/work_plan/wizardworkplanupdate(.:format)    {:action=>"wizardworkplanupdate", :controller=>"work_plans"}
#            partner_work_plan_weekly_rotas GET    /partners/:partner_id/work_plan/weekly_rotas(.:format)            {:action=>"index", :controller=>"weekly_rotas"}
#                                           POST   /partners/:partner_id/work_plan/weekly_rotas(.:format)            {:action=>"create", :controller=>"weekly_rotas"}
#         new_partner_work_plan_weekly_rota GET    /partners/:partner_id/work_plan/weekly_rotas/new(.:format)        {:action=>"new", :controller=>"weekly_rotas"}
#        edit_partner_work_plan_weekly_rota GET    /partners/:partner_id/work_plan/weekly_rotas/:id/edit(.:format)   {:action=>"edit", :controller=>"weekly_rotas"}
#             partner_work_plan_weekly_rota GET    /partners/:partner_id/work_plan/weekly_rotas/:id(.:format)        {:action=>"show", :controller=>"weekly_rotas"}
#                                           PUT    /partners/:partner_id/work_plan/weekly_rotas/:id(.:format)        {:action=>"update", :controller=>"weekly_rotas"}
#                                           DELETE /partners/:partner_id/work_plan/weekly_rotas/:id(.:format)        {:action=>"destroy", :controller=>"weekly_rotas"}
#                         partner_work_plan POST   /partners/:partner_id/work_plan(.:format)                         {:action=>"create", :controller=>"work_plans"}
#                     new_partner_work_plan GET    /partners/:partner_id/work_plan/new(.:format)                     {:action=>"new", :controller=>"work_plans"}
#                    edit_partner_work_plan GET    /partners/:partner_id/work_plan/edit(.:format)                    {:action=>"edit", :controller=>"work_plans"}
#                                           GET    /partners/:partner_id/work_plan(.:format)                         {:action=>"show", :controller=>"work_plans"}
#                                           PUT    /partners/:partner_id/work_plan(.:format)                         {:action=>"update", :controller=>"work_plans"}
#                                           DELETE /partners/:partner_id/work_plan(.:format)                         {:action=>"destroy", :controller=>"work_plans"}
#             holidaywizard_partner_holiday GET    /partners/:partner_id/holidays/:id/holidaywizard(.:format)        {:action=>"holidaywizard", :controller=>"holidays"}
#                          partner_holidays GET    /partners/:partner_id/holidays(.:format)                          {:action=>"index", :controller=>"holidays"}
#                                           POST   /partners/:partner_id/holidays(.:format)                          {:action=>"create", :controller=>"holidays"}
#                       new_partner_holiday GET    /partners/:partner_id/holidays/new(.:format)                      {:action=>"new", :controller=>"holidays"}
#                      edit_partner_holiday GET    /partners/:partner_id/holidays/:id/edit(.:format)                 {:action=>"edit", :controller=>"holidays"}
#                           partner_holiday GET    /partners/:partner_id/holidays/:id(.:format)                      {:action=>"show", :controller=>"holidays"}
#                                           PUT    /partners/:partner_id/holidays/:id(.:format)                      {:action=>"update", :controller=>"holidays"}
#                                           DELETE /partners/:partner_id/holidays/:id(.:format)                      {:action=>"destroy", :controller=>"holidays"}
#                      edit_partner_contact GET    /partners/:partner_id/contact/edit(.:format)                      {:action=>"edit", :controller=>"contacts"}
#                           partner_contact PUT    /partners/:partner_id/contact(.:format)                           {:action=>"update", :controller=>"contacts"}
#                            partner_shifts GET    /partners/:partner_id/shifts(.:format)                            {:action=>"index", :controller=>"shifts"}
#                                           POST   /partners/:partner_id/shifts(.:format)                            {:action=>"create", :controller=>"shifts"}
#                         new_partner_shift GET    /partners/:partner_id/shifts/new(.:format)                        {:action=>"new", :controller=>"shifts"}
#                        edit_partner_shift GET    /partners/:partner_id/shifts/:id/edit(.:format)                   {:action=>"edit", :controller=>"shifts"}
#                             partner_shift GET    /partners/:partner_id/shifts/:id(.:format)                        {:action=>"show", :controller=>"shifts"}
#                                           PUT    /partners/:partner_id/shifts/:id(.:format)                        {:action=>"update", :controller=>"shifts"}
#                                           DELETE /partners/:partner_id/shifts/:id(.:format)                        {:action=>"destroy", :controller=>"shifts"}
#       competencywizard_partner_competency GET    /partners/:partner_id/competency/competencywizard(.:format)       {:action=>"competencywizard", :controller=>"competencies"}
# wizardcompetencyupdate_partner_competency PUT    /partners/:partner_id/competency/wizardcompetencyupdate(.:format) {:action=>"wizardcompetencyupdate", :controller=>"competencies"}
#                   edit_partner_competency GET    /partners/:partner_id/competency/edit(.:format)                   {:action=>"edit", :controller=>"competencies"}
#                        partner_competency PUT    /partners/:partner_id/competency(.:format)                        {:action=>"update", :controller=>"competencies"}
#                                  partners GET    /partners(.:format)                                               {:action=>"index", :controller=>"partners"}
#                                           POST   /partners(.:format)                                               {:action=>"create", :controller=>"partners"}
#                               new_partner GET    /partners/new(.:format)                                           {:action=>"new", :controller=>"partners"}
#                              edit_partner GET    /partners/:id/edit(.:format)                                      {:action=>"edit", :controller=>"partners"}
#                                   partner GET    /partners/:id(.:format)                                           {:action=>"show", :controller=>"partners"}
#                                           PUT    /partners/:id(.:format)                                           {:action=>"update", :controller=>"partners"}
#                                           DELETE /partners/:id(.:format)                                           {:action=>"destroy", :controller=>"partners"}
