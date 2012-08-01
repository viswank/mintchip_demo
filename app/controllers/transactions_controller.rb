class TransactionsController < ApplicationController

  def index
#    @transaction = Transaction.new
  end

  def new
    @transaction = Transaction.new
  end

  def create
#    @transaction = Transaction.new(params[:transaction])
     
    @transaction = Transaction.new

#    if params[:valueMsg].isEmpty
#      flash[:error] = "Sorry. Your card cannot be generated. Please ensure you have a valid MintChip card with sufficient funds";
#      render 'new'      
#    end

    
    cardname = params[:payment]
    if cardname.to_s == "Visa"
      @transaction.cardType = 1
    elsif cardname.to_s == "MasterCard"
      @transaction.cardType = 2
    elsif cardname.to_s == "AMEX"
      @transaction.cardType = 3
    else      
      @transaction.cardType = 4      
    end
    
    @transaction.amount = params[:amount]
    @transaction.valueMsg = params[:valueMsg]    
    
    onetime = params[:one_time];
    if onetime == "1"
      @transaction.onetimeuse = 1
    else
      @transaction.onetimeuse = 100
    end
    
#    @transaction.amount = (params[:one_time]).to_i;
    
    
    
    cc_number = CC_gen(@transaction.cardType);
    cc_number1 = cc_number.join;
    cc_number2 = cc_number1.to_s;

    
    
    @transaction.cc_num = cc_number2;
    @transaction.exp_date = "1212"
    
    amount = @transaction.amount
    cardtype = @transaction.cardType
    cc_number2 = @transaction.cc_num
    
    
    str1 = "Virtual card successfully generated"  
    str2 = "Card Type = " + cardname.to_s  
    str3 = "Amount = $" + amount.to_s  
#    str3 = "Card Type = " + cardtype.to_s
    str4 = "Card Number = " + cc_number2.to_s 
    
#    str1 = str1 + str2 + str3+ str4;
    
    if @transaction.save
      flash[:success1] = str1;
     flash[:success2] = str2;
     flash[:success3] = str3;
     flash[:success4] = str4;
      
      redirect_to @transaction
    else
      render 'new'
    end
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

    def CC_gen (cardType)
#      str = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
      str = Array.new;
      sum = 0;
      final_digit = 0;
      t = 0;
      len_offset = 0;
      len = 0;
      
# visa      
      if cardType == 1 
        str[0] = 4;
        pos = 1; 
        len = 16;     
# Mastercard
      elsif cardType == 2
        str[0] = 5;
        t = Random.new.rand(1..5)
#        t = Math.floor(Math.random() * 5) % 5;
        str[1] = 1 + t; 
        pos = 2;
        len = 16;
# Amex        
      elsif cardType == 3
        str[0] = 3;
        t = Random.new.rand(4..7)
#        t = Math.floor(Math.random() * 4) % 4;
        str[1] = 4 + t; 
        pos = 2;
        len = 15;
# Discover
      elsif cardType == 4
        str[0] = 6;
        str[1] = 0;
        str[2] = 1;
        str[3] = 1;
        pos = 4;
        len = 16;
      end
     
      while (pos < len-1) do
        str[pos]=rand(10);
        pos = pos + 1;
      end
     
      len_offset = (len + 1) % 2;
      pos = 0
      for pos in 0..(len - 2) do 
        if (((pos + len_offset) % 2) == 1) 
           t = str[pos] * 2;
           if (t > 9)
              t = t - 9;
           end
           sum = sum + t;
           puts("t="+t.to_s);
        else 
           sum = sum + str[pos];
        end
      end
      final_digit = (10 - (sum % 10)) % 10;
      str[len-1] = final_digit;
      
#      return str.to_s;
#      str.join();
      return str;
           
    end
  
 

end