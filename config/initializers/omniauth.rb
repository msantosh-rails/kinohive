Rails.application.config.middleware.use OmniAuth::Builder do

	provider :facebook, '174948756034705', 'fc8d1dec114c483a333c8fc1b9a7582a'
	provider :identity, fields: [:email, :name], on_failed_registration: lambda { |env|
		IdentitiesController.action(:new).call(env)
	}
end


