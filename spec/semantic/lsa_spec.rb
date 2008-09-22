# require File.dirname(__FILE__) + '/../spec_helper'
# 
# describe Semantic::LSA do
# 
#   large_matrix=[[0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
#                 [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0],
#                 [1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0],
#                 [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]
# 
#   tiny_matrix = [[0.0, 1.0, 0.0], 
#                  [1.0, 0.0, 1.0]]
# 
#   u = Linalg::DMatrix.rows([[1,0],
#                             [0,1]])
# 
#   vt = Linalg::DMatrix.rows([[1,0,0],
#                              [1,0,0],
#                              [1,0,0]])
#                              
#   sigma = Linalg::DMatrix.rows([[1,0,0],
#                                 [0,1,0]])
# 
#   it "should create a new DMatrix from an array" do
#     Linalg::DMatrix.should_receive(:rows).with(tiny_matrix)
# 
#     lsa = Semantic::LSA.new(tiny_matrix)
#   end
# 
#   it "should output pretty lsa object" do
#     lsa = Semantic::LSA.new([[1,1,-1]])
# 
#     lsa.to_s.should == "[ +1.00 +1.00 -1.00 ]\n"
#   end
#   
#   it "should output lsa as an array" do
#     lsa = Semantic::LSA.new([[1,1,-1]])
#     
#     lsa.to_a.should eql([[1.0,1.0,-1.0]])
#   end
# 
# 
#   it "should run through an example" do
#     lsa = Semantic::LSA.new(large_matrix)
#     Semantic::LSA.should_receive(:new).and_return(lsa)
#     lsa.should_receive(:tf_idf_transform!)
#     lsa.should_receive(:lsa_transform!)
#         
#     Semantic::main()
#   end
# 
# end
