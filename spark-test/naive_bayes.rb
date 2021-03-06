require 'ruby-spark'

Spark.start

sc = Spark.sc

Spark::Mllib.import(Object)

# outlook, temperature, humidity, wind, play basketball
measures = [
  [ :sunny,    :hot,  :high,   :weak,   :yes ],
  [ :sunny,    :hot,  :high,   :strong, :no  ],
  [ :overcast, :hot,  :high,   :weak,   :yes ],
  [ :rain,     :mild, :high,   :weak,   :no  ],
  [ :rain,     :cool, :normal, :weak,   :no  ],
  [ :rain,     :cool, :normal, :strong, :no  ],
  [ :overcast, :cool, :normal, :strong, :no  ],
  [ :sunny,    :mild, :high,   :weak,   :yes ],
  [ :sunny,    :cool, :normal, :weak,   :yes ],
  [ :rain,     :mild, :normal, :weak,   :no  ],
  [ :sunny,    :mild, :normal, :strong, :yes ],
  [ :overcast, :mild, :high,   :strong, :yes ],
  [ :overcast, :hot,  :normal, :weak,   :yes ],
  [ :rain,     :mild, :high,   :strong, :no  ],
]

sym_to_v = {
  sunny:    1,
  overcast: 2,
  rain:     3,

  hot:      1,
  mild:     2,
  cool:     3,

  high:     1,
  normal:   2,

  weak:     1,
  strong:   2,

  yes:      1,
  no:       0,
}

data = []

measures[4..13].each do |m|
  data << LabeledPoint.new(sym_to_v[m[4]], [ sym_to_v[m[0]], sym_to_v[m[1]], sym_to_v[m[2]], sym_to_v[m[3]] ])
end

model = NaiveBayes.train(sc.parallelize(data))

# My personal assumptions
model.predict([sym_to_v[:sunny], sym_to_v[:mild], sym_to_v[:normal], sym_to_v[:weak]]) # should return 1, go play
model.predict([sym_to_v[:rain], sym_to_v[:cool], sym_to_v[:normal], sym_to_v[:strong]]) # should return 0, don't play

# Automatic test
measures[0..3].each do |m|
  v = [ sym_to_v[m[0]], sym_to_v[m[1]], sym_to_v[m[2]], sym_to_v[m[3]] ]
  puts "vector: #{v.join(', ')}"
  prediction =  model.predict(v)
  puts "prediction: #{prediction}"
  if prediction == sym_to_v[m[4]]
    puts "Matched!"
  else
    puts "Didn't match :-(" 
  end
  puts
end
