AdminUser.create email: "admin@hubud.org", password: "password", roles: [:superadmin], first_name: "John", last_name: "Doe"
AdminUser.create email: "manager@hubud.org", password: "password", roles: [:manager], first_name: "John"
AdminUser.create email: "host@hubud.org", password: "password", first_name: "John"
