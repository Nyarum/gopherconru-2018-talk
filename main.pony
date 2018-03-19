
use "time"

actor Collector
  let _summator: Summator
  var _count: U64

  new create(summator: Summator) =>
    _summator = summator
    _count = 0

  be collect() =>
    while _count < 10000000 do
      _summator.sum(_count)
      _count = _count + 1
    end

    _summator.print_result()

actor Summator
  var _sum: U64
  let _env: Env
  var _start_micros: U64

  new create(env: Env) =>
    _sum = 0
    _env = env
    _start_micros = Time.micros()

  be sum(i: U64 val) =>
    _sum = _sum + i

  be print_result() =>
    let bench_time = (Time.micros() - _start_micros) / 1000
    _env.out.print("Finished since - " + bench_time.string() + "ms, sum - " + _sum.string())

actor Main
  new create(env: Env) =>
    let sum = Summator(env)
    let col = Collector(sum)

    col.collect()