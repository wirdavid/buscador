require 'spec_helper'

describe User do
  before { 
    @data = {username: "username", name: "name", email: "mail@example.com", password: "qwerty", 
             password_confirmation: "qwerty", type: 1, status: true}
    @user = User.create! @data
  }



  subject { @user }
  it { should respond_to(:username)}
  it { @user.username = ""
       @user.should_not be_valid}
  it { should respond_to(:name)}
  it { @user.name = ""
       @user.should_not be_valid}
  it { should respond_to(:email)}
  it { @user.email = ""
       @user.should_not be_valid}
  it { should respond_to(:type)}
  it { @user.type = nil
       @user.should_not be_valid}
  it { should respond_to(:status)}
  it { @user.status = nil
       @user.should_not be_valid}
  
  context "Visitante" do

    before {@user.type = 3}
    
    it "Con tipo 3 es un visitante" do
      @user.should be_visitante
    end

    it "Con tipo diferente a 3 no es un visitante" do
      @user.type = 1
      @user.should_not be_visitante
    end

    it "Tiene publicaciones guardadas" do
      @user.should respond_to(:posts_saved)
    end
    
    it "Guarda publicacion" do
      post = mock_model("Post")
      Post.should_receive(:transaction)
      @user.save_post(post)
    end

    it "Agregar comentario a una publicacion" do
      post = mock_model("Post")
      comment = mock_model("Comment")

      post.should_receive(:add_comment).with(comment)
      @user.comment(post, comment)
    end

    it "Calificar una publicacion" do
      post = mock("Post")
      post.stub!(:rate).with(5).and_return(5)

      @user.rate(post,5).should == 5 
    end

    it "Debe poder suscribirse a un anunciante" do
      @data.update({username:"otherusername", email:"other@example.com"})
      otro_user = User.new(@data)

      @user.save
      otro_user.save

      @user.follow(otro_user)
      @user.subscriptions.count.should == 1
    end

  end
    
end
