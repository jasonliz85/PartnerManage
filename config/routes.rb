PartnerManager::Application.routes.draw do
	root :to => "partners#index"
	
	match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
	match '/shift_templates(/:year(/:month))' => 'shift_templates#index', :as => :shift_templates, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
	match '/shifts(/:year(/:month))' => 'shifts#index', :as => :shifts, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

	resources :partners do 
		resource :work_plan do
			resources :weekly_rotas
		end
		resources :holidays
		resource :contact
		resources :shifts
	end

end
#== Route Map
# Generated on 20 Dec 2010 15:27
#
#                               root        /(.:format)                                                     {:controller=>"articles", :action=>"index"}
#                           calendar        /calendar(/:year(/:month))(.:format)                            {:year=>/\d{4}/, :month=>/\d{1,2}/, :controller=>"calendar", :action=>"index"}
#                  holiday_templates        /holiday_templates(/:year(/:month))(.:format)                   {:year=>/\d{4}/, :month=>/\d{1,2}/, :controller=>"holiday_templates", :action=>"index"}
#                    shift_templates        /shift_templates(/:year(/:month))(.:format)                     {:year=>/\d{4}/, :month=>/\d{1,2}/, :controller=>"shift_templates", :action=>"index"}
#                             shifts        /shifts(/:year(/:month))(.:format)                              {:year=>/\d{4}/, :month=>/\d{1,2}/, :controller=>"shifts", :action=>"index"}
#     partner_work_plan_weekly_rotas GET    /partners/:partner_id/work_plan/weekly_rotas(.:format)          {:action=>"index", :controller=>"weekly_rotas"}
#                                    POST   /partners/:partner_id/work_plan/weekly_rotas(.:format)          {:action=>"create", :controller=>"weekly_rotas"}
#  new_partner_work_plan_weekly_rota GET    /partners/:partner_id/work_plan/weekly_rotas/new(.:format)      {:action=>"new", :controller=>"weekly_rotas"}
# edit_partner_work_plan_weekly_rota GET    /partners/:partner_id/work_plan/weekly_rotas/:id/edit(.:format) {:action=>"edit", :controller=>"weekly_rotas"}
#      partner_work_plan_weekly_rota GET    /partners/:partner_id/work_plan/weekly_rotas/:id(.:format)      {:action=>"show", :controller=>"weekly_rotas"}
#                                    PUT    /partners/:partner_id/work_plan/weekly_rotas/:id(.:format)      {:action=>"update", :controller=>"weekly_rotas"}
#                                    DELETE /partners/:partner_id/work_plan/weekly_rotas/:id(.:format)      {:action=>"destroy", :controller=>"weekly_rotas"}
#         partner_work_plan_holidays GET    /partners/:partner_id/work_plan/holidays(.:format)              {:action=>"index", :controller=>"holidays"}
#                                    POST   /partners/:partner_id/work_plan/holidays(.:format)              {:action=>"create", :controller=>"holidays"}
#      new_partner_work_plan_holiday GET    /partners/:partner_id/work_plan/holidays/new(.:format)          {:action=>"new", :controller=>"holidays"}
#     edit_partner_work_plan_holiday GET    /partners/:partner_id/work_plan/holidays/:id/edit(.:format)     {:action=>"edit", :controller=>"holidays"}
#          partner_work_plan_holiday GET    /partners/:partner_id/work_plan/holidays/:id(.:format)          {:action=>"show", :controller=>"holidays"}
#                                    PUT    /partners/:partner_id/work_plan/holidays/:id(.:format)          {:action=>"update", :controller=>"holidays"}
#                                    DELETE /partners/:partner_id/work_plan/holidays/:id(.:format)          {:action=>"destroy", :controller=>"holidays"}
#                  partner_work_plan POST   /partners/:partner_id/work_plan(.:format)                       {:action=>"create", :controller=>"work_plans"}
#              new_partner_work_plan GET    /partners/:partner_id/work_plan/new(.:format)                   {:action=>"new", :controller=>"work_plans"}
#             edit_partner_work_plan GET    /partners/:partner_id/work_plan/edit(.:format)                  {:action=>"edit", :controller=>"work_plans"}
#                                    GET    /partners/:partner_id/work_plan(.:format)                       {:action=>"show", :controller=>"work_plans"}
#                                    PUT    /partners/:partner_id/work_plan(.:format)                       {:action=>"update", :controller=>"work_plans"}
#                                    DELETE /partners/:partner_id/work_plan(.:format)                       {:action=>"destroy", :controller=>"work_plans"}
#                    partner_contact POST   /partners/:partner_id/contact(.:format)                         {:action=>"create", :controller=>"contacts"}
#                new_partner_contact GET    /partners/:partner_id/contact/new(.:format)                     {:action=>"new", :controller=>"contacts"}
#               edit_partner_contact GET    /partners/:partner_id/contact/edit(.:format)                    {:action=>"edit", :controller=>"contacts"}
#                                    GET    /partners/:partner_id/contact(.:format)                         {:action=>"show", :controller=>"contacts"}
#                                    PUT    /partners/:partner_id/contact(.:format)                         {:action=>"update", :controller=>"contacts"}
#                                    DELETE /partners/:partner_id/contact(.:format)                         {:action=>"destroy", :controller=>"contacts"}
#                     partner_shifts GET    /partners/:partner_id/shifts(.:format)                          {:action=>"index", :controller=>"shifts"}
#                                    POST   /partners/:partner_id/shifts(.:format)                          {:action=>"create", :controller=>"shifts"}
#                  new_partner_shift GET    /partners/:partner_id/shifts/new(.:format)                      {:action=>"new", :controller=>"shifts"}
#                 edit_partner_shift GET    /partners/:partner_id/shifts/:id/edit(.:format)                 {:action=>"edit", :controller=>"shifts"}
#                      partner_shift GET    /partners/:partner_id/shifts/:id(.:format)                      {:action=>"show", :controller=>"shifts"}
#                                    PUT    /partners/:partner_id/shifts/:id(.:format)                      {:action=>"update", :controller=>"shifts"}
#                                    DELETE /partners/:partner_id/shifts/:id(.:format)                      {:action=>"destroy", :controller=>"shifts"}
#                           partners GET    /partners(.:format)                                             {:action=>"index", :controller=>"partners"}
#                                    POST   /partners(.:format)                                             {:action=>"create", :controller=>"partners"}
#                        new_partner GET    /partners/new(.:format)                                         {:action=>"new", :controller=>"partners"}
#                       edit_partner GET    /partners/:id/edit(.:format)                                    {:action=>"edit", :controller=>"partners"}
#                            partner GET    /partners/:id(.:format)                                         {:action=>"show", :controller=>"partners"}
#                                    PUT    /partners/:id(.:format)                                         {:action=>"update", :controller=>"partners"}
#                                    DELETE /partners/:id(.:format)                                         {:action=>"destroy", :controller=>"partners"}
