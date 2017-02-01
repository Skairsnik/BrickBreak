//Parent class used for all Blocks and Players
class Block
{
    float positionX;
    float positionY;
    float blockWidth;
    float blockHeight;
    color blockCol;
    
    //Renders all blocks on the screen
    void renderBlock()
    {
        strokeWeight((width+height)*(.001));
        stroke(0);
        fill(blockCol);
        rect(positionX-blockWidth*(.5), positionY-blockHeight*(.5), blockWidth, blockHeight);
    }//end renderBlock
}//end class Block

//Sub-class for all non-Player blocks
class Destruct extends Block
{
    int type;
    
    //Destruct Constructor
    Destruct(float posX, float posY)
    {
        this.positionX = posX;
        this.positionY = posY;
        this.blockWidth = width*(.17);
        this.blockHeight = height*(.031);
    }//end Destruct()
    
    //Checks if the ball has collided with the brick from any angle or direction
    void checkBlock(int i, int x)
    {
        if(objBall.get(x).ballPos.y+objBall.get(x).ballDiam*(.5) > positionY-blockHeight*(.5) 
        && objBall.get(x).ballPos.y-objBall.get(x).ballDiam*(.5) < positionY+blockHeight*(.5)
        && objBall.get(x).ballPos.x > positionX-blockWidth*(.5)  
        && objBall.get(x).ballPos.x < positionX+blockWidth*(.5))
        {
            if(objBall.get(x).speed > 4)
            {
                objBall.get(x).speed -= .25; 
            }//end if
            
            if(type == 1)
            {
                ((PowerBlock)Grid.get(i)).hitPower();
                objPlayer.get(0).pScore += 75*objBall.get(x).scoreMultiplier;
            }//end if
            else if(type == 3)
            {
                ((HazardBlock)Grid.get(i)).hitHazard(x);
                objPlayer.get(0).pScore += 150*objBall.get(x).scoreMultiplier;
            }//end else if
            else
            {
                objPlayer.get(0).pScore += 100*objBall.get(x).scoreMultiplier;
            }//end else
            
            objBall.get(x).scoreMultiplier += .25;
            Grid.remove(i);
            
            if(objBall.get(x).theta >= HALF_PI && objBall.get(x).theta < PI)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, HALF_PI, PI, HALF_PI, 0);
                objBall.get(x).ballPos.y = positionY-blockHeight*(.5)-1;
            }//end if
            else if(objBall.get(x).theta >= PI && objBall.get(x).theta < HALF_PI*3)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, PI, HALF_PI*3, TWO_PI, HALF_PI*3);
            }//end else if
            else if(objBall.get(x).theta > 0 && objBall.get(x).theta < HALF_PI)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, 0, HALF_PI, PI, HALF_PI);
            }//end else if
            else if(objBall.get(x).theta >= HALF_PI*3 && objBall.get(x).theta <= TWO_PI)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, HALF_PI*3, TWO_PI, HALF_PI*3, PI);
            }//end else if
            else if(objBall.get(x).theta == 0)
            {
                objBall.get(x).theta = random(PI-HALF_PI/2, PI+HALF_PI/2);
            }//end else if
            
            if(objBall.get(x).ballPos.y > positionY)
            {
                objBall.get(x).ballPos.y = positionY+blockHeight*(.5)+1;
            }//end if
            else if(objBall.get(x).ballPos.y < positionY)
            {
                objBall.get(x).ballPos.y = positionY-blockHeight*(.5)-1;
            }//end else if
            
            objBall.get(x).forward.x = sin(objBall.get(x).theta);
            objBall.get(x).forward.y = -cos(objBall.get(x).theta);
            
            ParticleSystem temp = new ParticleSystem(new PVector(positionX, positionY));
            while(temp.particles.size() < 20)
            {
                temp.addParticle();
            }//end for
            
            pSystem.add(temp);
        }//end else if
        else if(objBall.get(x).ballPos.x+objBall.get(x).ballDiam*(.5) > positionX-blockWidth*(.5)  
             && objBall.get(x).ballPos.x-objBall.get(x).ballDiam*(.5) < positionX+blockWidth*(.5)
             && objBall.get(x).ballPos.y > positionY-blockHeight*(.5) 
             && objBall.get(x).ballPos.y < positionY+blockHeight*(.5))
        {
            if(objBall.get(x).speed > 4)
            {
                objBall.get(x).speed -= .25; 
            }//end if
            
            if(type == 1)
            {
                ((PowerBlock)Grid.get(i)).hitPower();
            }//end if
            else if(type == 3)
            {
                ((HazardBlock)Grid.get(i)).hitHazard(x);
            }//end else if
            
            Grid.remove(i);
            
            if(objBall.get(x).theta >= HALF_PI && objBall.get(x).theta < PI)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, HALF_PI, PI, HALF_PI*3, PI);
            }//end if
            else if(objBall.get(x).theta >= PI && objBall.get(x).theta < HALF_PI*3)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, PI, HALF_PI*3, PI, HALF_PI);
            }//end else if
            else if(objBall.get(x).theta > 0 && objBall.get(x).theta < HALF_PI)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, 0, HALF_PI, TWO_PI, HALF_PI*3);
            }//end else if
            else if(objBall.get(x).theta >= HALF_PI*3 && objBall.get(x).theta <= TWO_PI)
            {
                objBall.get(x).theta = map(objBall.get(x).theta, HALF_PI*3, TWO_PI, HALF_PI, 0);
            }//end else if
            
            if(objBall.get(x).ballPos.x > positionX)
            {
                objBall.get(x).ballPos.x = positionX+blockWidth*(.5)+1;
            }//end if
            else if(objBall.get(x).ballPos.x < positionX)
            {
                objBall.get(x).ballPos.x = positionX-blockWidth*(.5)-1;
            }//end else if
            
            objBall.get(x).forward.x = sin(objBall.get(x).theta);
            objBall.get(x).forward.y = -cos(objBall.get(x).theta);
            
            ParticleSystem temp = new ParticleSystem(new PVector(positionX, positionY));
            while(temp.particles.size() < 20)
            {
                temp.addParticle();
            }//end for
            pSystem.add(temp);
        }//end else if
    }//end checkBlock
}//end class Destruct

//Sub-class for the power(Green) blocks
class PowerBlock extends Destruct
{
    //PowerBlock Constructor
    PowerBlock(float posX, float posY)
    {
        super(posX, posY);
        this.type = 1;
        this.blockCol = color(random(50,75), random(100,255), random(50,75));
    }//end PowerBlock
    
    //Gives the user a second ball to destroy more blocks faster
    void hitPower()
    {
        Ball newBall = new Ball();
        objBall.add(newBall);
    }//end hitPoswer()
}//end clss PowerBlock

//Sub-class for the normal(Blue) blocks
class NormalBlock extends Destruct
{
    //NormalBlock Constructor
    NormalBlock(float posX, float posY)
    {
        super(posX, posY);
        this.type = 2;
        this.blockCol = color(random(50,75), random(50,75), random(100,255));
    }//end NormalBlock
    
    //NO UNIQUE METHODS FOR THE NORMAL BLOCKS
}//end clss NormalBlock

//Sub-class for the hazard(Red) blocks
class HazardBlock extends Destruct
{
    //HazardBlock Constructor
    HazardBlock(float posX, float posY)
    {
        super(posX, posY);
        this.type = 3;
        this.blockCol = color(random(150,255), random(75,100), random(75,100));
    }//end HazardBlock
    
    //When a hazard is hit 2 is added to the balls speed
    void hitHazard(int x)
    {
        objBall.get(x).speed = objBall.get(x).speed+2;
    }//end hitHazard()
}//end clss HazardBlock

class ParticleSystem
{
    ArrayList<Particles> particles;
    PVector origin;
    int Lifespan;
  
    ParticleSystem(PVector position)
    {
        this.origin = position.copy();
        this.particles = new ArrayList<Particles>();
        this.Lifespan = 100;
    }
  
    void addParticle()
    {
        particles.add(new Particles(origin));
    }//end addParticle()
  
    void run()
    {
        for (int i = particles.size()-1; i >= 0; i--)
        {
            Particles p = particles.get(i);
            p.runEffect();
            
            if (p.isDead())
            {
                particles.remove(i);
            }//end if
        }//end for
    }//end run()
}//end ParticleSystem

class Particles
{
    PVector position;
    PVector velocity;
    PVector acceleration;
    int lifespan;
    
    Particles(PVector orig)
    {
        this.position = new PVector(random(orig.x-width*(.17)*(.5), orig.x+width*(.17)*(.5)), orig.y);
        this.velocity = new PVector(random(-1, 1), random(-2,0));
        this.acceleration = new PVector(0, 0.05);
        this.lifespan = 255;
    }//end ParticleEffect
    
    void runEffect()
    {
        updateParticle();
        displayParticle();
    }//end runEffect()
    
    void updateParticle()
    {
        velocity.add(acceleration);
        position.add(velocity);
        lifespan -= 2.55;
    }//end updateParticle()
    
    void displayParticle()
    {
        stroke(random(150,255), random(75,100), random(75,100), lifespan);
        fill(random(150,255), random(75,100), random(75,100), lifespan);
        ellipse(position.x, position.y, (width+height)*(.005), (width+height)*(.005));
    }//end displayParticle()
    
    boolean isDead()
    {
        if (lifespan < 0.0)
        {
            return true;
        }//end if
        else
        {
            return false;
        }//end else
    }//end isDead()
}//end class ParticleEffect