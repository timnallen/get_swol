class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email, :api_key
end
