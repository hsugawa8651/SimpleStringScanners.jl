using SimpleStringScanners
using Test

@testset "SimpleStringScanners.jl" begin

    @testset "advance!" begin
        scan = SimpleStringScanner("abcdef")
        @test_throws AssertionError advance!(scan, 0)
        @test !eos(scan)
        @test advance!(scan, 1) == "a"
        @test !eos(scan)
        @test advance!(scan, 2) == "bc"
        @test !eos(scan)
        @test advance!(scan, 3) == "def"
        @test eos(scan)
        @test_throws BoundsError advance!(scan, 1)
    end

    @testset "scan!(Int64,)" begin
        scanner = SimpleStringScanner(" 12 34")
        @test scan!(scanner, r"\d+").match == "12"
        @test !eos(scanner)
        @test scan!(scanner, r"\d+").match == "34"
        @test eos(scanner)
    end

    @testset "parse(Int64,)" begin
        @test parse1(Int64, "1") == 1
        @test_throws ArgumentError parse1(Int64, "a")
        @test parse1(Int64, "a"; base = 16) == 10
        #
        @test tryparse1(Int64, "1") == 1
        @test isnothing(tryparse1(Int64, "a"))
        @test tryparse1(Int64, "a"; base = 16) == 10
    end

    @testset "parseInt64(" begin
        @test parseInt64("1") == 1
        @test_throws ArgumentError parseInt64("a")
        @test parseInt64("a"; base = 16) == 10
        #
        @test tryparse1Int64("1") == 1
        @test isnothing(tryparse1Int64("a"))
        @test tryparse1Int64("a"; base = 16) == 10
    end

    @testset "parseInt64(SimpleStringScanner" begin
        scan = SimpleStringScanner("123")
        @test parseInt64(scan, 1) == 1
        @test parseInt64(scan, 2) == 23
        @test eos(scan)
    end

    @testset "parse(Float64," begin
        @test_throws ArgumentError parse(Float64, "1d-3")
        @test parse1(Float64, "1d-3") == 1e-3
        #
        @test_throws ArgumentError parse(Float64, "1c-3")
        @test_throws ArgumentError parse1(Float64, "1c-3")
    end

    @testset "tryparse(Float64," begin
        @test_throws ArgumentError parseFloat64("1d-3")
        @test isapprox(parse1Float64("1d-3"), 1e-3)
        #
        @test_throws ArgumentError parseFloat64("1c-3")
        @test_throws ArgumentError parse1Float64("1c-3")
    end

    @testset "tryparseFloat64" begin
        @test isnothing(tryparseFloat64("1d-3"))
        @test tryparse1Float64("1d-3") == 1e-3
        #
        @test isnothing(tryparseFloat64("1c-3"))
        @test isnothing(tryparse1Float64("1c-3"))
    end

    @testset "tryparse1Float64(SimpleStringScanner" begin
        scan = SimpleStringScanner("1d-3")
        @test isapprox(tryparse1Float64(scan, 4), 1e-3)
        @test eos(scan)
    end

    @testset "tryparse1(Int64,)" begin
        scanner = SimpleStringScanner(" 12 34")
        @test !eos(scanner)
        @test tryparse1(Int64, scanner, r"\d+") == 12
        @test !eos(scanner)
        @test tryparse1(Int64, scanner, r"\d+") == 34
        @test eos(scanner)
    end

    @testset "tryparse1(Int64; base=2)" begin
        scanner = SimpleStringScanner(" 10 11")
        @test !eos(scanner)
        @test tryparse1(Int64, scanner, r"\d+"; base=2) == 2
        @test !eos(scanner)
        @test tryparse1(Int64, scanner, r"\d+"; base=2) == 3
        @test eos(scanner)
    end

end
