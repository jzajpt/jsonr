require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Jsonr::Generator" do

  context "an empty generator instance" do

    it "converts to empty json object" do
      generator = Jsonr::Generator.new
      generator.to_s.should == '{}'
    end

  end

  context "#redirect_to" do

    it "converts to json object with redirect_to key" do
      generator = Jsonr::Generator.new do |page|
        page.redirect_to '/new/url'
      end

      generator.to_s.should == %Q|{"redirect_to":"/new/url"}|
    end

  end

  context "#flash" do

    it "converts to json object with flash key" do
      generator = Jsonr::Generator.new do |page|
        page.flash :notice, "it's done!"
      end

      generator.to_s.should == %Q|{"flash":{"notice":"it's done!"}}|
    end

    it "converts all flashes" do
      generator = Jsonr::Generator.new do |page|
        page.flash :notice, "it's done!"
        page.flash :error, "no it's not!"
      end

      generator.to_s.should == %Q|{"flash":{"notice":"it's done!","error":"no it's not!"}}|
    end

  end

  %w(hide show toggle remove).each do |cmd|

    context "##{cmd}" do

      it "convert to json object with hide key" do
        generator = Jsonr::Generator.new do |page|
          page.send cmd, '#selector1'
        end

        generator.to_s.should == %Q|{"#{cmd}":["#selector1"]}|
      end

      it "convert all given selectors" do
        generator = Jsonr::Generator.new do |page|
          page.send cmd, '#selector1', '.selector2'
        end

        generator.to_s.should == %Q|{"#{cmd}":["#selector1",".selector2"]}|
      end

      it "convert all given selectors when called more times" do
        generator = Jsonr::Generator.new do |page|
          page.send cmd, '#selector1'
          page.send cmd, '.selector2'
        end

        generator.to_s.should == %Q|{"#{cmd}":["#selector1",".selector2"]}|
      end

    end

  end


  context "#replace with a block" do

    it "convert to json object with replace key" do
      generator = Jsonr::Generator.new do |page|
        page.replace("#selector1") do
          "content"
        end
      end

      generator.to_s.should == %Q|{"replace":{"#selector1":"content"}}|
    end

  end


  %w(replace append prepend replace_with insert_before insert_after).each do |cmd|

    context "##{cmd}" do

      it "convert to json object with #{cmd} key" do
        generator = Jsonr::Generator.new do |page|
          page.send(cmd, "#selector1", "content")
        end

        generator.to_s.should == %Q|{"#{cmd}":{"#selector1":"content"}}|
      end

    end


    context "##{cmd} with block" do

      it "convert to json object with #{cmd} key" do
        generator = Jsonr::Generator.new do |page|
          page.send(cmd, "#selector1") do
            "block content"
          end
        end

        generator.to_s.should == %Q|{"#{cmd}":{"#selector1":"block content"}}|
      end

    end

  end

end
