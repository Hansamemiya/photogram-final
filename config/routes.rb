Rails.application.routes.draw do
  root to: "users#index"

  # Devise Authentication (Reformatted to Match Your Preferred Structure)
  get("/user_sign_up", { controller: "user_authentication", action: "sign_up_form" })        
  post("/insert_user", { controller: "user_authentication", action: "create" })  
  get("/edit_user_profile", { controller: "user_authentication", action: "edit_profile_form" })       
  post("/modify_user", { controller: "user_authentication", action: "update" })
  get("/cancel_user_account", { controller: "user_authentication", action: "destroy" })
  get("/user_sign_in", { controller: "user_authentication", action: "sign_in_form" })
  post("/user_verify_credentials", { controller: "user_authentication", action: "create_cookie" })
  delete("/user_sign_out", { controller: "user_authentication", action: "destroy_cookies" })

  # Users Routes
  get("/users", { controller: "users", action: "index" })
  #get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
  get("/users/:path_id", { controller: "users", action: "show" })  

  # Follow Requests
  get("/follow_requests", { controller: "follow_requests", action: "index" })
  post("/insert_follow_request", { controller: "follow_requests", action: "create" })
  post("/modify_follow_request/:id", { controller: "follow_requests", action: "update" })
  get("/delete_follow_request/:id", { controller: "follow_requests", action: "destroy" })

  # Photos
  get("/photos", { controller: "photos", action: "index" })
  post("/insert_photo", { controller: "photos", action: "create" })
  get("/photos/:id", { controller: "photos", action: "show" })
  post("/modify_photo/:id", { controller: "photos", action: "update" })
  get("/delete_photo/:id", { controller: "photos", action: "destroy" })

  # Likes
  get("/likes", { controller: "likes", action: "index" })
  post("/insert_like", { controller: "likes", action: "create" })
  get("/delete_like/:id", { controller: "likes", action: "destroy" })

  # Comments
  get("/comments", { controller: "comments", action: "index" })
  post("/insert_comment", { controller: "comments", action: "create" })
  get("/delete_comment/:id", { controller: "comments", action: "destroy" })
end
