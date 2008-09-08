require File.dirname(__FILE__) + '/spec_helper'

describe LSA do

  large_matrix=[[0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 1.0],
                [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.0],
                [1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0],
                [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]]

  tiny_matrix = [[0.0, 1.0, 0.0], 
                 [1.0, 0.0, 1.0]]

  u = Linalg::DMatrix.rows([[1,0],
                            [0,1]])

  vt = Linalg::DMatrix.rows([[1,0,0],
                             [1,0,0],
                             [1,0,0]])
                             
  sigma = Linalg::DMatrix.rows([[1,0,0],
                                [0,1,0]])

  it "should create a new DMatrix from an array" do
    Linalg::DMatrix.should_receive(:rows).with(tiny_matrix)

    lsa = LSA.new(tiny_matrix)
  end

  it "should output pretty lsa object" do
    lsa = LSA.new([[1,1,-1]])

    lsa.to_s.should == "[ +1.00 +1.00 -1.00 ]\n"
  end
  
  it "should output lsa as an array" do
    lsa = LSA.new([[1,1,-1]])
    
    lsa.to_a.should eql([[1.0,1.0,-1.0]])
  end

  describe "term frequency / inverse document frequency transform" do

    it "should find the number of times each term occurs" do
      lsa = LSA.new([[1]])
      lsa.should_receive(:get_term_document_occurences).with(0).and_return(2)

      lsa.tf_idf_transform!
    end
    
    it "should ignore counting terms with 0 weighting" do
      lsa = LSA.new([[0]])
      lsa.should_not_receive(:get_term_document_occurences)
      
      lsa.tf_idf_transform!
    end
    
    it "should calculate term frequency" do
      lsa = LSA.new([[1,2]])
      Frequency.should_receive(:term_frequency).with(1.0, 3.0).and_return(1.0)
      Frequency.should_receive(:term_frequency).with(2.0, 3.0).and_return(1.0)

      lsa.tf_idf_transform!
    end

    it "should calculate inverse document frequency" do
      lsa = LSA.new([[1,0],[1,1]])
      Frequency.should_receive(:inverse_document_frequency).with(2, 2).twice.and_return(1.0)  
      Frequency.should_receive(:inverse_document_frequency).with(2, 1).and_return(1.0)    
            
      lsa.tf_idf_transform!
    end

    it "should transform LSA matrix" do
      lsa = LSA.new(tiny_matrix)

      lsa.tf_idf_transform!
      # lsa.to_a.should == [[0.0, 0.693147180559945, 0.0], [0.346573590279973, 0.0, 0.346573590279973]]
      # <=>
      lsa.to_s.should == "[ +0.00 +0.69 +0.00 ]\n[ +0.35 +0.00 +0.35 ]\n"
    end

  end

  describe "latent semantic analysis transform" do

    it "should use svd on matrix" do
      matrix = Linalg::DMatrix.rows(tiny_matrix)
      matrix.should_receive(:singular_value_decomposition).and_return([u, sigma, vt])

      Linalg::DMatrix.stub!(:rows).and_return(matrix)

      lsa = LSA.new(matrix)
      lsa.lsa_transform!
    end

    it "should reduce the noise in the sigma matrix" do
      matrix = Linalg::DMatrix.rows(tiny_matrix)
      matrix.stub!(:singular_value_decomposition).and_return([u, sigma, vt])
      Linalg::DMatrix.stub!(:rows).and_return(matrix)

      sigma.should_receive(:[]=).with(0,0,0)
      sigma.should_receive(:[]=).with(1,1,0)
      
      lsa = LSA.new(large_matrix)
      lsa.lsa_transform! 2
    end

    it "should prevent reducing dimensions greater than the matrixes own dimensions" do
      lsa = LSA.new(tiny_matrix)
      lambda { lsa.lsa_transform! 100 }.should raise_error(Exception)
    end
    
    it "should transform LSA matrix" do
      lsa = LSA.new(tiny_matrix)
      
      lsa.tf_idf_transform!
      lsa.lsa_transform!

      lsa.to_s.should == "[ +0.00 +0.69 +0.00 ]\n[ +0.00 +0.00 +0.00 ]\n"
    end

  end

  it "should run through an example" do
    lsa = LSA.new(large_matrix)
    LSA.should_receive(:new).and_return(lsa)
    lsa.should_receive(:tf_idf_transform!)
    lsa.should_receive(:lsa_transform!)
    
    main()
  end

end
