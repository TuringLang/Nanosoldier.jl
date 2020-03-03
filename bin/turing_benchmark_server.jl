using Distributed
import Nanosoldier, GitHub

nodes = Dict(Any => addprocs())
@everywhere import Nanosoldier

auth = GitHub.authenticate(ENV["GITHUB_AUTH"])
secret = ENV["GITHUB_SECRET"]

config = Nanosoldier.Config(ENV["USER"], nodes, auth, secret;
                            workdir = joinpath(homedir(), "test_workdir"),
                            trackrepo = "KDr2/Turing.jl",
                            reportrepo = "KDr2/BenchmarkReports",
			    trigger =  r"\@BayesBot\s*`runbenchmarks\(.*?\)`",
			    admin = "KDr2",
                            testmode = true)

server = Nanosoldier.Server(config)


using Sockets
run(server, IPv4(0,0,0,0), 8080)

