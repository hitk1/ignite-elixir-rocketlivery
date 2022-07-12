ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Rocketlivery.Repo, :manual)

# Todos os mocks tem de ser definidos aqui para, assim a lib Mox le todos os behaviours e cria automaticamente todos os mocks necessários
# Obrigatoriamente, tem de ser implementados em cima dos behaviours
Mox.defmock(Rocketlivery.ViaCep.ClientMock, for: Rocketlivery.ViaCep.Behaviour)
