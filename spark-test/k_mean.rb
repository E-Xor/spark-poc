require 'ruby-spark'

Spark.start

sc = Spark.sc

Spark::Mllib.import

data = [
  DenseVector.new([0.0,0.0]),
  DenseVector.new([1.0,1.0]),
  DenseVector.new([2.0,1.0]),
  DenseVector.new([1.0,2.0]),
  DenseVector.new([5.0,5.0]),
  DenseVector.new([7.0,3.0]),
  DenseVector.new([10.0,10.0]),
  DenseVector.new([1.0,10.0]),
  DenseVector.new([10.0,10.0]),

  DenseVector.new([100.0,100.0]),
  DenseVector.new([90.0,80.0]),
  DenseVector.new([80.0,90.0]),
  DenseVector.new([86.0,97.0]),
  DenseVector.new([82.0,98.0]),
  DenseVector.new([80.0,70.0]),
  DenseVector.new([89.0,90.0]),
  DenseVector.new([80.0,85.0]),
  DenseVector.new([85.0,90.0]),
  DenseVector.new([80.0,95.0])
]

model = KMeans.train(sc.parallelize(data), 4) # last aprameter - number of centers/clusters

puts model.centers # centers of cluster
puts model.predict([0.0, 0.0]) # index of cluster (from model.center) point belongs to
puts model.predict([8.0, 9.0])

Spark.stop
