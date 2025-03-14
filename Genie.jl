using Pkg
Pkg.add("HTTP")
Pkg.add("JSON")
Pkg.add("Genie")
using Genie

Genie.Generator.newapp("BlogAPI", force = true)

const posts = Dict{Int, Any}()
post_id_counter = Ref(0)

route("/posts", method=GET) do 
    JSON.json(posts)
    
end

route("/posts", method=POST) do
    new_post = jsonpayload()
    post_id_counter[] += 1
    posts[post_id_counter[]] = new_post
    json(new_post)
  end

route("/posts/:id", method=PUT) do
  post_id = parse(Int, params["id"])
  new_data = jsonpayload()
  posts[post_id] = new_data
  json(new_data)
end
    
route("/posts/:id", method=DELETE) do
  post_id = parse(Int, params["id"])
  deleted_post = posts[post_id]
  delete!(posts, post_id)
  json(deleted_post)
end

up(8000)
