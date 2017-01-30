require 'ruby-spark'

Spark.start

sc = Spark.sc

Spark::Mllib.import(Object)

data = [
  LabeledPoint.new(0.0, [0.0]),
  LabeledPoint.new(1.0, [1.0]),
  LabeledPoint.new(3.0, [2.0]),
  LabeledPoint.new(2.0, [3.0])
]


lrm = LinearRegressionWithSGD.train(sc.parallelize(data), initial_weights: [1.0], iterations: 20)

res = lrm.predict([9.1])

puts "MAKSIM res: #{res}" 

Spark.stop
