Ox0700                             $ox$info        $ox$end    $ox$literals �                    	   Variables               ActionVariable               Shared               StateVariable               Clock               TimeInvariant               DPAuxiliary      DP.ox      Ptrans      Sync      Density      find      rind      Aind      pandv      Nxt   "   Must be called before CreateSpaces   
   StateBlock      RandomEffectBlock      FixedEffectBlock   
   Coevolving      CorrelatedEffect   	   SubEffect   :   Error: can't add variable after calling DP::CreateSpaces()   3   Error: can't add states before calling Initialize()      Discrete      N      Theta      nested state blocks not allowed      block      pos   '   Cannot add variable with non-positive N      TimeVariable   *   Clock subvector must contain TimeVariables   Y   Error: random effect cannot be added AFTER any fixed effects have been added to the model      RandomEffect   /   Only add RandomEffects to random effects vector      FixedEffect   -   Only add FixedEffects to fixed effects vector      ActionVariable   .   Only add ActionVariables to the action vector       StateVariable   '   Only add StateVariable to state vectors      D      size      C      subv   (   argument is not a TimeInvariant variable      L      vals   6   Error: can't add auxiliary before calling Initialize()      AuxiliaryVariable      not an AuxiliaryVariable      left      right      v      Run      FETask      loop      GLike   A   Must call DP::Delete between calls to CreateSpaces and Initialize      NOISY   =   DP::Intialize is complete. Action and State spaces are empty.      Update time must be an integer   �   Setting update time to OnlyOnce. Transitions and actual values do not depend on fixed or random effect values.  If they do, results are not reliable.   �   Setting update time to AfterFixed. Transitions and actual values can depend on fixed effect values but not random effects.  If they do, results are not reliable.   �   Setting update time to AfterRandom. Transitions and actual values can depend on fixed and random effects, which is safe but may be redundant and therefore slower than necessary.   /   Update time must be between 0 and UpdateTimes-1   :   State Space Already Defined. Call CreateSpaces() only once   C   No actions added to the model. A no-choice action inserted for you.      M      X   !   setting clock type to stationary.      r      f      s      %u1      bpos      ActDimensions   
   Dimensions               �?               @              �?       @              @              @      @              @              @      @              @              @              @      @              �?       @      @      @      @      @     O                   
   Stationary   /   canNOT use state list in stationary environment   	   IsErgodic   ?   -------------------- DP Model Summary ------------------------
      %      Clock:       .       STATE VARIABLES
      %18s      |eps      |eta      |theta      -clock      |gamma      %r   
          s.N      %cf      %7.0f      %c      Fixed   	   NonRandom      Random   	   Augmented   3   
Transition Categories (not counting fixed or time)   
        #Vars      %13.0f      
Size of Spaces              Exogenous          SemiExogenous             Endogenous                  Times          EV()Iterating          Ch.Prob.track           Random Groups           Fixed Groups          TotalUntrimmed      %10.0f      
ACTION VARIABLES (       distinct actions)          i.N   2   NOTE: time is ergodic but terminal states exist???      
 Trimming           TotalReachable               Terminal      
ACTION SETS      %-14s   	       alpha        A[      %1u      ]             (      )          	       X       	       -       
   #States         %9u   4   
    Key: X = row vector is feasible. - = infeasible   ?       Actions vectors not shown because they are never feasible:       DP      Bellman      Update      list                               �?     Transit                   8   Exogenous and Semi-Exogenous State Variable Transitions       f()      %15.6f      actual   -   Clock/counter state block already initialized      Clock   ,   Sorry! Regime Change clock not supported yet      t      Last      Distribution      state      current      subspace      Traverse      Transition time:       StationaryDistribution   
   *** Group    *   stationary distribution calculation failed   )   stationary distribution may be unreliable      pdf      
      %6.0f      Index      T      A       rind               EV      |      index      maxP*      sum(P)      Choice Probabilities:      %5.0f      %9.6f      ind   
   IsTerminal      EV      ExpandP      OneDimensionalChoice      zstar    $ox$end    $ox$symbols      arglist 0            $arglist            constant 0�          cc$constant           dval       r       declu 0        
   cccc$declu           ma       aml       amu       amp       diagonal 0�       
   c$diagonal           ma       format 0           c$format           sfmt       isarray 0        	   c$isarray           a       isclass 0�       	   c$isclass           a       isdouble 0        
   c$isdouble           a    
   isfunction 0           c$isfunction           a       isint 0           c$isint           a       ismatrix 0        
   c$ismatrix           a       ismember 0           cc$ismember           obj       smember    	   maxcindex 0           c$maxcindex           a       min 0�          c$min           a       ones 0�          c$ones           r    
   oxrunerror 0�          c$oxrunerror           smsg    	   oxwarning 0           c$oxwarning           flset       print 0�          c$print           a       println 0�       	   c$println           a       reshape 0           ccc$reshape           ma       r       c       reversec 0        
   c$reversec           ma    	   selectifr 0           cc$selectifr           ma       mif       setdiagonal 0           cc$setdiagonal           ma       mdiag       solvelu 0           cccc$solvelu           ml       mu       mp       mb       sprint 0�          c$sprint           a       sprintbuffer 0           c$sprintbuffer           len       strfind 0�       
   cc$strfind           as       s       sumc 0           c$sumc           ma       timer 0            $timer         
   va_arglist 0            $va_arglist            vecr 0           c$vecr           ma    	   vecrindex 0�          c$vecrindex           ma       zeros 0�          c$zeros           r        d          d         d         d         d         d         d         d  @       d          d         d         d  ����    d          d         d         d         d  -DT�!	@    d  -DT�!@    d  -DT�!�?    d  ���m0_�?    d  '��@    d  iW�
�@    d  �o��x�?    d        �    d        �    d        �    d        ��    d         d        �<    d  5       d  �������    d            d  ���    d  �      d  >���    d  �      d  ����    d  4      d  ���    d        ��    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d          d         d         d         d          d         d         d         d         d         d         d         d         d  	       d  
       d  
         Infinite Horizon       Ergodic       Normal Finite Horizon Aging    '   Static Program (finite horizon and T=1)    K   Random Aging (finite horizon but aging happens with probability<1 at some t    X   Random Mortaility (finite horizon with probability of early transition to last t, death)    J   Uncertain Longevity (finite horizon until last period which ends randomly)       Regime Change       Social Experiment       User Defined Clock     d          d         d         d          d         d         d         d         d         d         d          d         d         d         d          d         d         d          d         d         d         d           sample size       mean       st.dev.       min       max     d  :�0�yE>    d  :�0�yE>    d  �h㈵��>    d  -C��6?   CV 0�            $CV           X       ReverseState 0              $ReverseState           Ind       O       DrawOne 0         	    $DrawOne           P       Zauxilliary        ����       Discretized       �     Zauxilliary    nodes $	        N  	        lt  	        av  	        m  	        z  	        ff  	        nxtp  	        nxtf  	        i  	        indx  	        np  	        pts  	        f  	        p  	           Approx 0           cc  $Approx           this       $t0       x       trans       Discretized 0           cc $Discretized           this       $t0       nodes       Quantity       ����   L $	        pos  	        v  	            Discrete       �     Quantity    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	           Discrete 0           cc  $Discrete           this       $t0       L       N       PDF 0           cc$PDF           this       $t0       Update 0        	   cc$Update           this       $t0    	   Parameter       �     Quantity    L $	        pos  	        v  	        NearFlat $ -C��6?   sep $         DoNotConstrain          ival $	     	   DoNotVary  	        f  	        block  	        start  	        scale  	           Decode 0        
   cc $Decode           this       $t0       f       Encode 0        	   cc$Encode           this       $t0    	   Parameter 0           cc  $Parameter           this       $t0       L       ival       Reset 0        
   cc  $Reset           this       $t0       newv       IsCode       ToggleDoNotVary 0           cc$ToggleDoNotVary           this       $t0       Integration        �     Zauxilliary        GaussianQuadrature        �     Integration        GQL       �     GaussianQuadrature    nodes          wght          
   Initialize 0           cc $Initialize           this       $t0       order       GQH       �     GaussianQuadrature    order          nodes          wght          
   Initialize 0           cc $Initialize           this       $t0       order       coef 0           cc $coef           this       $t0       n       GHK       �     Integration    J $	        M $	        R $	        hR $	        iseed $	        SimJ $	        L  	        u  	        nu  	        pk  	        prob  	           GHK 0        	   cc   $GHK           this       $t0       R       J       iseed       SimDP 0        
   cc  $SimDP           this       $t0       V       Sigma       SimProb 0           cc   $SimProb           this       $t0       j       V       Sigma       Version       �     Zauxilliary    MinOxVersion $ �     version $ d      checked             Check 0           cc$Check           this       $t0    	   Equations       �     Zauxilliary    rlabels $          lamba       values    L $	        N $	        v  	        J  	        lam  	        	   Equations 0           cc $Equations           this       $t0       LorN       norm 0           cc$norm           this       $t0       penalty 0        
   cc$penalty           this       $t0       print 0           cc$print           this       $t0       Equality       �  	   Equations    rlabels $          lamba       values    L $	        N $	        v  	        J  	        lam  	           Equality 0           cc $Equality           this       $t0       LorN       print 0           cc$print           this       $t0    
   InEquality       �  	   Equations    rlabels $          lamba       values    L $	        N $	        v  	        J  	        lam  	        
   InEquality 0           cc $InEquality           this       $t0       LorN       print 0           cc$print           this       $t0       Point    	   �     Zauxilliary    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	           Copy 0           cc $Copy           this       $t0       h       GCopy 0        	   cc $GCopy           this       $t0       h       Point 0           cc$Point           this       $t0    	   aggregate 0           cc  $aggregate           this       $t0       V  @        v  @        SepPoint       �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	        Kvar $	        bb $	           SepPoint 0           cc  $SepPoint           this       $t0       Kvar       bb    	   aggregate 0           cc  $aggregate           this       $t0       V  @        v  @        MixPoint       �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	        Dvar $	        sp $	        WF  	        W  	        mix  	           Copy 0           cc $Copy           this       $t0       h       MixPoint 0           cc  $MixPoint           this       $t0       Dvar       sp    	   aggregate 0           cc  $aggregate           this       $t0       V  @        v  @        CPoint       �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	        L  	        eq  	        ineq  	           CPoint 0           cc  $CPoint           this       $t0       e       i       Copy 0           cc $Copy           this       $t0       h       Vec 0           cc$Vec           this       $t0       ActionVariable       �     Discrete    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	           ActionVariable 0           cc  $ActionVariable           this       $t0       L  @    a    N  @       BinaryChoice       �     ActionVariable    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	           BinaryChoice 0           cc$BinaryChoice           this       $t0        d          d         d        StateVariable    	   �     Discrete    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	           MakeTerminal 0           cc $MakeTerminal           this       $t0    
   TermValues       StateVariable 0           cc  $StateVariable           this       $t0       L  @    s    N  @       Transit 0           cc $Transit           this       $t0       FeasA    	   UnChanged 0           cc $UnChanged           this       $t0       FeasA       UnReachable 0           cc $UnReachable           this       $t0       clock  @     
   Autonomous    	   �     StateVariable    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	         	   NonRandom    	   �  
   Autonomous    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	            Random    	   �  
   Autonomous    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	         	   Augmented    
   �  
   Autonomous    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        b $        	   Augmented 0           cc $Augmented           this       $t0       b    	   Triggered          	   Augmented    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        b $        t $        tv $        rval $        ft          idx          idy          rv          tr          nf             Transit 0           cc $Transit           this       $t0       FeasA    	   Triggered 0           cc    $Triggered           this       $t0       b       t       tv  @        rval  @        ActionTriggered         	   Triggered    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        b $        t $        tv $        rval $        ft          idx          idy          rv          tr          nf             ActionTriggered 0           cc    $ActionTriggered           this       $t0       b       t       tv  @       rval  @        Transit 0           cc $Transit           this       $t0       FeasA       ValueTriggered         	   Triggered    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        b $        t $        tv $        rval $        ft          idx          idy          rv          tr          nf             Transit 0           cc $Transit           this       $t0       FeasA       ValueTriggered 0           cc    $ValueTriggered           this       $t0       b       t       tv  @       rval  @        Reset            ActionTriggered    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        b $        t $        tv $        rval $        ft          idx          idy          rv          tr          nf             Reset 0        
   cc  $Reset           this       $t0       b       t       Forget            ActionTriggered    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        b $        t $        tv $        rval $        ft          idx          idy          rv          tr          nf          pstate $           Forget 0           cc   $Forget           this       $t0       b       pstate       rval  @        Transit 0           cc $Transit           this       $t0       FeasA       UnReachable 0           cc $UnReachable           this       $t0       clock  @        Offer       �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Pi $	        Accept $	           Offer 0           cc    $Offer           this       $t0       L       N       Pi       Accept       Transit 0           cc $Transit           this       $t0       FeasA       Update 0        	   cc$Update           this       $t0       LogNormalOffer            Offer    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Pi $	        Accept $	        mu $	        sigma $	           LogNormalOffer 0           cc      $LogNormalOffer           this       $t0       L       N       Pi       Accept       mu       sigma       Update 0        	   cc$Update           this       $t0       Jump    
   �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Pi $	           Jump 0        
   cc   $Jump           this       $t0       L       N       Pi       Transit 0           cc $Transit           this       $t0       FeasA       Fixed    	   �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	           Fixed 0        	   cc $Fixed           this       $t0       L       Transit 0           cc $Transit           this       $t0       FeasA       RandomUpDown       �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        down $        hold $       up $       NRUP $       fPi $	        fp  	           RandomUpDown 0           cc   $RandomUpDown           this       $t0       L       N       fPi       Transit 0           cc $Transit           this       $t0       FeasA    
   SimpleJump    	   �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        
   SimpleJump 0           cc  $SimpleJump           this       $t0       L       N       Transit 0           cc $Transit           this       $t0       FeasA    	   Absorbing       �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        fPi $	        p  	        	   Absorbing 0           cc  $Absorbing           this       $t0       L  @        fPi  @       �?   Transit 0           cc $Transit           this       $t0       FeasA    	   Zvariable    	     
   SimpleJump    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	           Update 0        	   cc$Update           this       $t0    	   Zvariable 0           cc  $Zvariable           this       $t0       L       Ndraws       Lagged    
   �  	   NonRandom    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	           Lagged 0           cc  $Lagged           this       $t0       L       Target       Transit 0           cc $Transit           this       $t0       FeasA       Update 0        	   cc$Update           this       $t0       LaggedState    
        Lagged    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	           LaggedState 0           cc  $LaggedState           this       $t0       L       Target       Transit 0           cc $Transit           this       $t0       FeasA       LaggedAction    
        Lagged    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	           LaggedAction 0           cc  $LaggedAction           this       $t0       L       Target       Transit 0           cc $Transit           this       $t0       FeasA       PermanentChoice    
        LaggedAction    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	           PermanentChoice 0           cc  $PermanentChoice           this       $t0       L       Target       Transit 0           cc $Transit           this       $t0       FeasA       Counter       �  	   NonRandom    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	        Reset $	        Prune  	        Warned  	           Counter 0           cc      $Counter           this       $t0       L       N       Target       ToTrack       Reset       Prune       Transit 0           cc $Transit           this       $t0       FeasA       UnReachable 0           cc $UnReachable           this       $t0       clock  @        StateCounter            Counter    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	        Reset $	        Prune  	        Warned  	           StateCounter 0           cc      $StateCounter           this       $t0       L       N       Target       ToTrack  @             �?   Reset  @        Prune  @       Transit 0           cc $Transit           this       $t0       FeasA       ActionCounter            Counter    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	        Reset $	        Prune  	        Warned  	        inc  	           ActionCounter 0           cc      $ActionCounter           this       $t0       L       N       Target       ToTrack  @             �?   Reset  @        Prune  @        Transit 0           cc $Transit           this       $t0       FeasA       Accumulator    
   �  	   NonRandom    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	           Accumulator 0           cc   $Accumulator           this       $t0       L       N       Target       Transit 0           cc $Transit           this       $t0       FeasA       ActionAccumulator            Accumulator    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        x  	        y  	           ActionAccumulator 0           cc   $ActionAccumulator           this       $t0       L       N       Target       Transit 0           cc $Transit           this       $t0       FeasA       StateAccumulator    
        Accumulator    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	           StateAccumulator 0           cc   $StateAccumulator           this       $t0       L       N       Target       Transit 0           cc $Transit           this       $t0       FeasA       Duration            Counter    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	        Reset $	        Prune  	        Warned  	        Current $	        Lag $	        isact $	        nf  	        g  	           Duration 0           cc     $Duration           this       $t0       L       Current       Lag       N       Prune  @       Transit 0           cc $Transit           this       $t0       FeasA       RetainMatch       �  	   NonRandom    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	     
   matchvalue $	        acc $	        replace $	        keep $	        i  	        repl  	        hold  	           RetainMatch 0           cc    $RetainMatch           this       $t0    
   matchvalue       acc       replace       keep       Transit 0           cc $Transit           this       $t0       FeasA       Deterministic    
   �  	   NonRandom    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        nextValueHash  	           Deterministic 0           cc   $Deterministic           this       $t0       L       N       nextValueHash       Transit 0           cc $Transit           this       $t0       FeasA       Cycle    
        Deterministic    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        nextValueHash  	           Cycle 0        
   cc  $Cycle           this       $t0       L       N       Renewal       �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        reset $	        Pi $	        P $	           Renewal 0           cc    $Renewal           this       $t0       L       N       reset       Pi       Transit 0           cc $Transit           this       $t0       FeasA       Tracker       �  	   NonRandom    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	           Tracker 0           cc   $Tracker           this       $t0       L       Target       ToTrack       StateTracker            Tracker    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	           StateTracker 0           cc   $StateTracker           this       $t0       L       Target       ToTrack       Transit 0           cc $Transit           this       $t0       FeasA       ActionTracker            Tracker    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Target $	        ToTrack $	        d  	           ActionTracker 0           cc   $ActionTracker           this       $t0       L       Target       ToTrack       Transit 0           cc $Transit           this       $t0       FeasA    
   Coevolving       �     StateVariable    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        block  	        bpos  	        
   Coevolving 0           cc  $Coevolving           this       $t0       L       N    
   StateBlock       �     StateVariable    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        
   AddToBlock 0�           cc $AddToBlock           this       $t0       s    
   StateBlock 0           cc $StateBlock           this       $t0       L       Transit 0           cc $Transit           this       $t0       FeasA       OfferWithLayoff       !  
   StateBlock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        Unemp $        Quit $       LaidOff $       Emp $       Nstatus $       Pi $	        Lambda $	        NN $	        accept $	        offer $	        status $	           Employed 0           cc$Employed           this       $t0       OfferWithLayoff 0           cc     $OfferWithLayoff           this       $t0       L       N       accept       Pi       Lambda    	   Searching 0           cc$Searching           this       $t0       Transit 0           cc $Transit           this       $t0       FeasA       NormalComponent          
   Coevolving    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        block  	        bpos  	           NormalComponent 0           cc  $NormalComponent           this       $t0       L       N       MVNormal       !  
   StateBlock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        M $	        mu $	        CholLT $	        Ngridpoints $	        Grid  	           MVNormal 0           cc     $MVNormal           this       $t0       L       N       M       mu       CholLT       Transit 0           cc $Transit           this       $t0       FeasA       Update 0        	   cc$Update           this       $t0       Episode       !  
   StateBlock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        Onset $	        End $	        Finite $	        k $	        t $	        probT  	           Episode 0           cc      $Episode           this       $t0       L       K       T    	   StartProb       EndProb       Finite       Transit 0           cc $Transit           this       $t0       FeasA       Tauchen       �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        mu $	        rho $	        sig $	        M $	        gaps $	        rnge  	        pts  	        s  	        r  	        Grid  	           Tauchen 0           cc      $Tauchen           this       $t0       L       N       M       mu       sig       rho       Transit 0           cc $Transit           this       $t0       FeasA       Update 0        	   cc$Update           this       $t0       Asset       �     Random    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	     
   NetSavings $	        r $	        atom  	        top  	        bot  	        mid  	        all  	        tprob  	        bprob  	           Asset 0           cc    $Asset           this       $t0       L       N       r    
   NetSavings       Transit 0           cc $Transit           this       $t0       FeasA       TimeVariable          
   Coevolving    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        block  	        bpos  	           TimeVariable 0           cc  $TimeVariable           this       $t0       L  @    t    N  @       Clock       !  
   StateBlock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar             Clock 0        
   cc  $Clock           this       $t0       Nt       Ntprime       Solving 0           cc   $Solving           this       $t0       ME       aVV       aSPstar       Vupdate 0           cc $Vupdate           this       $t0       VV       setPstar 0           cc$setPstar           this       $t0    
   Stationary       )     Clock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar             Last 0           cc$Last           this       $t0    
   Stationary 0           cc $Stationary           this       $t0    	   IsErgodic  @        Transit 0           cc $Transit           this       $t0       FeasA       NonStationary       )     Clock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar             Last 0           cc$Last           this       $t0       Aging       +     NonStationary    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar             Aging 0        	   cc $Aging           this       $t0       T       Transit 0           cc $Transit           this       $t0       FeasA       setPstar 0           cc$setPstar           this       $t0       StaticP       ,     Aging    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar             StaticP 0        
   cc$StaticP           this       $t0       NonDeterministicAging       +     NonStationary    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar             Vupdate 0           cc $Vupdate           this       $t0       VV       sePstar 0        
   cc$sePstar           this       $t0       AgeBrackets       .     NonDeterministicAging    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar          Brackets $	        TransMatrix  	           AgeBrackets 0           cc $AgeBrackets           this       $t0       Brackets       Last 0           cc$Last           this       $t0       Transit 0           cc $Transit           this       $t0       FeasA       setPstar 0           cc$setPstar           this       $t0    	   Mortality       .     NonDeterministicAging    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar          MortProb $	        Tstar $	        DeathV  	        mp  	        	   Mortality 0           cc  $Mortality           this       $t0       T       MortProb       Transit 0           cc $Transit           this       $t0       FeasA       Vupdate 0           cc $Vupdate           this       $t0       now       setPstar 0           cc$setPstar           this       $t0    	   Longevity       0  	   Mortality    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar          MortProb $	        Tstar $	        DeathV  	        mp  	        twilight $	           Last 0           cc$Last           this       $t0    	   Longevity 0           cc  $Longevity           this       $t0       T       MortProb       Transit 0           cc $Transit           this       $t0       FeasA       Vupdate 0           cc $Vupdate           this       $t0       now       setPstar 0           cc$setPstar           this       $t0       PhasedTreatment       )     Clock    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        t $	        tprime $	     	   IsErgodic $	        ME          aVV          aSPstar          Rmaxes $	        MaxF $	        R0 $	     	   LastPhase $	        ftime $	        phase $	        final $	           PhasedTreatment 0           cc  $PhasedTreatment           this       $t0       Rmaxes    	   IsErgodic       Transit 0           cc $Transit           this       $t0       FeasA       Vupdate 0           cc $Vupdate           this       $t0       now       TimeInvariant    	   �     StateVariable    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	           Transit 0           cc $Transit           this       $t0       FeasA       Update 0        	   cc$Update           this       $t0       FixedEffect    	   3     TimeInvariant    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	           FixedEffect 0           cc  $FixedEffect           this       $t0       L  @    FE    N  @       RandomEffect    	   3     TimeInvariant    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	           Distribution 0           cc$Distribution           this       $t0       RandomEffect 0           cc  $RandomEffect           this       $t0       L  @    RE    N  @    	   SubEffect       4     FixedEffect    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        block  	        bpos  	        	   SubEffect 0           cc  $SubEffect           this       $t0       L  @    SubFE    N  @       FixedEffectBlock       4     FixedEffect    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        
   AddToBlock 0�           cc $AddToBlock           this       $t0       s       FixedEffectBlock 0           cc $FixedEffectBlock           this       $t0       L  @    FEBlock    CorrelatedEffect       5     RandomEffect    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        block  	        bpos  	           CorrelatedEffect 0           cc  $CorrelatedEffect           this       $t0       L  @    CorrRE    N  @       RandomEffectBlock       5     RandomEffect    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        Theta  	        Allv  	        
   AddToBlock 0�           cc $AddToBlock           this       $t0       s       Distribution 0           cc$Distribution           this       $t0       RandomEffectBlock 0           cc $RandomEffectBlock           this       $t0       L  @    REBlock    NormalRandomEffect       5     RandomEffect    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        mu $	        sigma $	           Distribution 0           cc$Distribution           this       $t0       NormalRandomEffect 0           cc    $NormalRandomEffect           this       $t0       L       N       mu       sigma       TauchenRandomEffect       :     NormalRandomEffect    L $	        pos  	        v  	        vals $	        N  	        actual  	        pdf  	     
   TermValues  	        subv  	        mu $	        sigma $	        M $	           Distribution 0           cc$Distribution           this       $t0       TauchenRandomEffect 0           cc     $TauchenRandomEffect           this       $t0       L       N       mu       sigma       M       Space       �     Zauxilliary    D  	        N  	        C  	        X  	        M  	        size  	           Space 0           cc$Space           this       $t0       SubSpace       �     Zauxilliary 
   ClockIndex          Tlength          S          D  	        size  	        O  	        left  	        right  	           ActDimensions 0           cc$ActDimensions           this       $t0    
   Dimensions 0           cc  $Dimensions           this       $t0       subs       UseLast       SubSpace 0           cc$SubSpace           this       $t0       AuxiliaryVariable       �     Quantity    L $	        pos  	        v  	           AuxiliaryVariable 0           cc $AuxiliaryVariable           this       $t0       L       Realize 0           cc  $Realize           this       $t0       q       y       RealizedUtility       >     AuxiliaryVariable    L $	        pos  	        v  	           Realize 0           cc  $Realize           this       $t0       q       y       RealizedUtility 0           cc$RealizedUtility           this       $t0       ZetaRealization       �     Quantity    L $	        pos  	        v  	        length $	           Realize 0           cc  $Realize           this       $t0       q       y       ZetaRealization 0           cc $ZetaRealization           this       $t0       length        `          `          `          d          d         d         d         d         d          d         d         d         d         d         d         d         d         d          d         d         d         d         d         d         d         d         d  	       d  
       d         d         d          d         d         d          d         d         d         d          d         d         d         d          d         d         d         d        DP    L   ����   sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd       $      Actions  �    9     cc $Actions          this       $t0       Act1    	   AddStates      �     cc  $AddStates          this       $t0       SubV       va       AuxiliaryOutcomes  �          cc $AuxiliaryOutcomes          this       $t0       v1       CreateSpaces      �     cc$CreateSpaces          this       $t0       CurGroup      '      cc$CurGroup          this       $t0    	   DoNothing      �     cc$DoNothing          this       $t0    	   DrawGroup      �      cc $DrawGroup          this       $t0       find       DrawOneExogenous      �      cc $DrawOneExogenous          this       $t0       aState       EndogenousStates  �    �     cc $EndogenousStates          this       $t0       v1       ExogenousStates  �    �     cc $ExogenousStates          this       $t0       v1       ExogenousTransition      F     cc$ExogenousTransition          this       $t0       GetAind      �      cc $GetAind          this       $t0       i       GetPstar           cc $GetPstar          this       $t0       i       GetTrans      %     cc  $GetTrans          this       $t0       i       h       Gett      }     cc$Gett          this       $t0       GroupVariables  �    �     cc $GroupVariables          this       $t0       v1    
   Initialize      \     cc   $Initialize          this       $t0       userReachable       UseStateList  @        GroupExists  @        InitialsetPstar      @     cc $InitialsetPstar          this       $t0       task       IsBlock      a     cc $IsBlock          this       $t0       sv       IsBlockMember      {     cc $IsBlockMember          this       $t0       sv       Last      �     cc$Last          this       $t0    
   MakeGroups 0           cc$MakeGroups           this       $t0    
   ResetGroup            cc $ResetGroup          this       $t0       g       SaveV 0�        	   cc $SaveV           this       $t0       ToScreen       SemiExogenousStates  �    �     cc $SemiExogenousStates          this       $t0       v1       SetClock  �    �     cc $SetClock          this       $t0    	   ClockType       SetDelta           cc $SetDelta          this       $t0       delta       SetGroup      6      cc $SetGroup          this       $t0       state       SetUpdateTime      ]     cc $SetUpdateTime          this       $t0       time  @       Settheta      �      cc $Settheta          this       $t0       ind       StorePalpha      N     cc$StorePalpha          this       $t0       SubSampleStates      �     cc $SubSampleStates          this       $t0       SampleProportion  @       �?   Swap      �     cc$Swap          this       $t0       SyncAct      �     cc $SyncAct          this       $t0       a       UpdateDistribution 0           cc$UpdateDistribution           this       $t0       UpdateVariables      �     cc $UpdateVariables          this       $t0       state  @        Task    U   o     DP    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	     	      OutputValue 0           cc$OutputValue           this       $t0       Reset      &     cc$Reset          this       $t0       Run 0           cc $Run           this       $t0       th    
   SyncStates      ,     cc  $SyncStates          this       $t0       dmin       dmax       Task           cc$Task          this       $t0       Traverse  �         cc $Traverse          this       $t0       arg0       Update      �  	   cc$Update          this       $t0       list  �    �     cc $list          this       $t0       arg0       loop      �     cc$loop          this       $t0       CTask    U   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	           CTask      A     cc$CTask          this       $t0       Run      q     cc $Run          this       $t0       th    
   EndogTrans    V   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        current  	        
   EndogTrans 0           cc$EndogTrans           this       $t0       Run 0           cc $Run           this       $t0       th       EnTask    U   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	           EnTask      �  	   cc$EnTask          this       $t0       ExTask    U   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	           ExTask      �  	   cc$ExTask          this       $t0    	   GroupTask    W   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	        	   GroupTask      �     cc$GroupTask          this       $t0       Run 0           cc $Run           this       $t0       gam       loop      �     cc$loop          this       $t0       CGTask    W   u  	   GroupTask    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	           CGTask      �  	   cc$CGTask          this       $t0       Run           cc $Run          this       $t0       g       RETask    W   u  	   GroupTask    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	           RETask      7  	   cc$RETask          this       $t0       SetFE        	   cc $SetFE          this       $t0       f       FETask    W   u  	   GroupTask    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	           FETask      �  	   cc$FETask          this       $t0       UpdateDensity    W   w     RETask    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	           Run      �     cc $Run          this       $t0       g       UpdateDensity      �     cc$UpdateDensity          this       $t0    	   DPMixture    W   w     RETask    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	        	   DPMixture      =     cc$DPMixture          this       $t0       Run      I     cc $Run          this       $t0       g       SDTask    W   w     RETask    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        span $	        qtask  	           Run      r     cc $Run          this       $t0       g       SDTask      f  	   cc$SDTask          this       $t0       Group    Y   o     DP    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          l          u          p          PT          statbvector          pos  	        find  	        rind  	        state  	        Ptrans  	        Palpha  	     	   Pinfinity  	        mobj  	           Density      c  
   cc$Density          this       $t0       DrawfromStationary      �     cc$DrawfromStationary          this       $t0       Group      �  
   cc  $Group          this       $t0       pos       task       StationaryDistribution      A     cc$StationaryDistribution          this       $t0       Sync      �     cc$Sync          this       $t0       ~Group      o  	   cc$~Group          this       $t0       DPDebug    \   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        div $ N   ------------------------------------------------------------------------------    prtfmt0          prtfmt       	   SimLabels          Vlabels          MaxChoiceIndex          Vlabel0          
   Initialize      ;     cc$Initialize          this       $t0       outV        
   cc   $outV          this       $t0       ToScreen  @       aOutMat  @        MaxChoiceIndex  @        SaveV    c   }     DPDebug    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        div $ N   ------------------------------------------------------------------------------    prtfmt0          prtfmt       	   SimLabels          Vlabels          MaxChoiceIndex          Vlabel0          ToScreen $	        aM $	        re  	        stub  	        nottop  	        r  	        s  	           Run           cc $Run          this       $t0       th       SaveV      �     cc   $SaveV          this       $t0       ToScreen  @       aM  @        MaxChoiceIndex  @        DumpExogTrans    V   p     Task    sfmt $    %4.0f    ThetaCreated          Warned          UseStateList          NN          NG          NF          NR       	   ClockType          counter          TT       	   IsErgodic          HasBeenUpdated          HasFixedEffect       
   UpdateTime          ReachableIndices          NReachableStates          StorePA          OO          S          SS          States          NS          NA          Nav          J          AA          ActionMatrix          Asets       
   ActionSets       	   AsetCount          A          Blocks       
   SubVectors          Slabels          Alabels       	   Auxlabels          cputime0          Sfmts          Vlabels          Volume          find          rind          gind          gdist          curREdensity          ind          delta          curt          tfirst          NTerminalStates          NxtExog          F          P          now          later          setPstar          userReachable          GroupExists       	   PreUpdate          PostRESolve          V          ETT          ialpha          alpha          zeta          chi          Chi          Naux          SampleProportion          Approximated          DoSubSample          MedianExogState          MESind       	   MSemiEind       
   MxEndogInd          left $	        right $	        state  	        subspace  	        iter  	        d  	        done  	        trips  	        MaxTrips  	        s  	           DumpExogTrans      `     cc$DumpExogTrans          this       $t0       Run      �     cc $Run          this       $t0       th       $ox$end 	   $ox$pcode             q   #	   I    P    L
  u   #
   F   A   P    c	   P    r   m    O�   x    O�   P    l    X   #
   A   P    c
   P    M    #   A   P    c   P    M    #   R   #   R    #   q   #   I    P    r    L�   P    L
  u+   x    #   R   #   R    #   q   #   I    P    L
  P    L
   1   C   FK   L
  r    u   P   x    O�   x    1   O[   OL   JL   A   U+   #   L   P    r    L�   P    L
  u+   x    C   #   F�   r    L�   P    L
  u+   x    P    c
   P    M    #   r    L�   P    L
  u+   x    P    c   P    M    #   L
  P    r    L�   P    L
  u+   x    P    c   P    m    U)   #   L
  P    r    L�   P    L
  u+   x    P    c   P    m    U*   #   r    L�   P    L
  u+   x    #   R   #   R    #   q   #"   I    P    L
  P   P    L
  1   P    L   P    L
  r    u,   1   x    O�   x    C   Oc   M   #"   R   #"   R    #"   q   #$   I   P    L   P    L
  r    u3   P   x    C   b    #%   r   A   P    d   x    P    L~   P    L
  r    u3   P    x    2    x    P    L
  r    u   P   x    O�   x    C   Oc   X   #&   B    #'   R   #'   R    #(   q   #*   I    P    r    L�   1   x    #*   R   #*   R    #*   q   #0   I    P    L   P    r    L�   1   x    C   F  r    L�   1   x    P    c   P    m    J  i����#0   R   #0   R    #0   q   #6   I    P    r    L�   1   x    P    c   P    m    P    r    L�   P    L
  u+   x    P    c   P    m    x    #6   R   #6   R    #6   q   #?   I    P    P    p   P    r    L�   1   x    P    c   P    m    P    x    1   x    Og   Ou   P    r    L�   1   x    P    c   P    m    P   x    1   x    Og   Ou   #?   R   #?   R    #?   q   #D   I    P    L
  u   #E   F[  L   P    c   C   #E   L
  P   U   #F   R    #G   q   #M   I    P    L   1   P    c   C   Tv  L   1   P    c   C   Tv  L   1   P    c   C   #P   R   #P   R    #Q   q   #W   I    P    L   1   P    c   C   T�  L   1   P    c   C   T�  L   1   P    c   C   #Z   R   #Z   R    #[   q   #c   I   P    L
  u   #e   F�  L   P    c   C   #e   L   P    L
  u!   C   O^   #f   F�  L   P    c   P    C   #f   L   P    A   P    c   C   #g   F�  P    p   1   Og   Ou   a   #g   i    0    #h   0    P    A   f�   P   0    P    4   P   @����J�  L
  P    i   P    L
  P    r    A   P    B   x    M   #i   FW  i    b   #j   B   P    r    A   P    B   x    P    c   P    m    O   T�  J=  B   OJ   b   J�  L
  P    i   P    L
  P    r    A   P    B   x    P    c   P    m    P    B   x    M   #k   F
  L   P    c   C   #k   L
  P   P    L
  1   P    r    A   2   x    P    c   P    m    2   x    M   #l   r    A   2   x    P    c   P    m    2   x    P    c   P    0    r    A   2   x    n)  #m   r   A   2   x    P    c   P    m    2   P    X   #n   J�  r    A   2   x    P    c   P    0    L
  u    f�   nD  #p   L
  d   u    P    r    A   2   x    Ou   U    #q   J�  #r   r    A   P    B   x    P    c   P    m    P    i   O   #t   Fj  L   P    c    C   #t   A   #u   P    Jo  J   -    d   P   O{   F�  L   P    r    A   P    B   x    P    c!   C   O^   #v   F�  L   P    c"   C   #v   Jn  -    d   P   O{   F�  r    A   P    B   x    P    c   P    m    P    i   O}   #w   F�  L
  u   #x   F�  L   P    c#   C   #x   L   P    r    A   P    B   x    P    c$   C   O^   #y   F�  L   P    c%   C   #y   Jn  -    d   P   O{   F�  L   P    r    A   P    B   x    P    c&   C   O^   #{   F�  L   P    c'   C   #{   L
  P   U   #|   Jn  -    d   P    O{   F�  L   P    r    A   P    B   x    P    c(   C   O^   #}   F�  L   P    c)   P    C   #}   Jn  -    P    L   P    r    A   P    B   x    P    c*   C   O^   #~   F�  L   P    c+   C   #~   Jn  -    L
  r    u   1   x    P    c,   P    0    d   m    E    -    OJ   n	  O,   b    #�   L
  r   u!   1   d   x    P    r    A   2   x    Ou   X   #�   L
  r    u   1   x    P    c   P    0    d   m    E    -    P    r    A   2   x    P    c   P    m    Ou   n)  #�   L
  r    u   1   x    P    c-   P    0    d   m    E    -    P    r    A   2   x    P    c   P    m    O[   nB  #�   B    #�   F�  L
  r    u   1   x    P    c.   P    0    d   m    E    -    P    L
  r    u   1   x    P    c.   P    m    2    P   OY   x    P    L
  r    u   1   x    P    c   P    m    2    x    O[   OF   n^  #�   J�  L
  r    u   1   x    P    c.   P    0    L
  r    u   1   x    P    c   P    m    2    x    n�  #�   A   P    i    O�   #�   F�  r    A   2   x    P    c/   P    0    A   n�  #�   J�  R    #�   q   #�   I    P    L
  P   P    L
  P   1   P    L   C    Ou   M   #�   R    #�   q   #�   I    P    L
  P   P    L
  P   1   P    L   C    Ou   M   #�   R    #�   q   #�   I    P    L
  P   P    L
  P   1   P    L   C    Ou   M   #�   R    #�   q   #�   I   P    P    p   1   Og   Ou   P    L   C    Ou   b    #�   i    0    #�   0    P    B    f�   P   0    P    4   P   @����J7  L   P    r    B    P    B   x    P    c&   C   #�   F  L
  P   P    L
  P   P    r    B    2   x    M   #�   J6  L   P    r    B    P    B   x    P    c$   C   #�   F1  L
  P   P    L
  P   P    r    B    2   x    M   #�   J6  L   P    c0   C   #�   J�  R    #�   q   #�   I   P    P    p   1   Og   Ou   P    L   C    Ou   b    L
  r    u   P    x    P    c,   P    m    b   #�   L
  P   P    L
  P    2    M   #�   i    0    #�   0    P    B    f�   P   0    P    4   P   @����J�  r    B    2   x    P    c   P    0    B   no  #�   L
  d   u   P    r    B    2   x    P    c   P    m    Ou   U   #�   r    B    2   x    P    c1   P    m    P    P ���L   P   P    r    B    2   x    P    c1   P    m    f�   P   OY   C   O(   x    b   #�   B   O^   #�   F�  L
  P    r    B    2   x    P    c2   P    m    Os   U   #�   L
  P    P    p   2   Og   Ou   U#   #�   J�  L
  d   u#   2   Ou   U#   #�   L
  u   f�   b   #�   L
  d   u   P    L   P    L
  u   P    r    B    2   x    P    c   P    m    P   OY   2   O[   2   C   Ou   U   #�   L
  d   u   P    L   P    r    B    2   x    P    c2   P    m    Os   P    L   P   2   C   O[   C   OF   U   #�   B   OJ   b   #�   Jd  R    #�   q   #�   I   P    L   P    L
  u!   C   O^   #�   F  L   P    c3   P    C   #�   A   P    L   C    Ou   b    L
  uC   f�   b   #�   i    0    #�   0    P    B    f�   P   0    P    4   P   @����J|  L   P    r    B    P    B   x    P    c4   C   O^   #�   F=  L   P    c5   C   #�   L
  d   uC   P    r    B    2   x    Ou   UC   #�   B   O^   #�   F^  L
  P    P    p   P    r    B    2   x    P    c1   P    m    Og   Ou   U$   #�   Jm  L
  d   u$   P    r    B    2   x    P    c1   P    m    Ou   U$   #�   r    B    2   x    P    c   P    0    B   OJ   b   O,   nt  #�   J'  L
  P    L
  uC   f�   UD   #�   R    #�   q   #�   I    1    P   P    L  M    #�   A    P   UU   #�   A    P    L
  r    u   1    uU   x    P    c6   P    m    UL   #�   A    P    L
  r    u   1    uU   x    P    c7   P    m    UM   #�   A    R   #�   q   #�   I    P    L	   P    A    uN   C   #�   F�  A    P    L
  u   P   OY   UN   #�   J�  A    P   P    L  M    #�   A    P   P    L  1    uL   1    uM   M   #�   A    1    uL   P   Oc   UQ   #�   A    r   uN   1    uL   1    uQ   P   OY   O(   P    L
  r    u   1    uL   1    uQ   P   OY   O(   x    P   OY   X   #�   A    P   P    L  1    uL   1    uQ   P   OY   M   #�   L
  r    u   1    uL   x    P    c8   P    0    A    r    uN   1    uL   x    n  #�   A    P   P    L  1    uL   1    uL   M   #�   L
  r   u.   O�   P    L
  u   1    uN   O[   X   #�   L
  P    L
  r    u.   P   x    OL   U+   #�   A    P    c9   P    P    L   1    P    c:   C   FB  A    uN   JH  r    L�   P    L
  u+   x    M   #�   A    r   uN   P    A    uL   d   x    O,   X   P    i    O|   #�   T  A    r   uN   1    uL   P    X   #�   A    P   P    L  1    uL   1    uL   M   #�   A    1    uL   P    L   1    r    uN   1    uL   1    uM   O(   x    P   Ou   C   O9   Oc   UQ   #�   A    uQ   P    A    uM   O~   #�   F�  A    r   uN   1    uQ   d   x    O,   X   #�   A    P   P    L  1    uQ   1    uQ   M   #�   A    uQ   P    A    uM   O~   #�   T�  R    #�   q   #�   I   1    P    P    L  M    #�   A    r   uN   1    uL   1    uM   O(   P    L
  r    u   1    uL   1    uM   O(   x    P   OY   X   #�   P    L
  u   p   S�   #�   P    L
  u   P    L
  u   p   S�   #�   L
  P    L    P    L
  u   P    L
  u   C   U,   #�   A    P    c;   P    M    #�   i    b   i    b   #�   B   P    L
  u   O   T�  J  B   OJ   b   J�  i    0    #�   0    P    L
  u   P   0    P    4    P   @����J  r   L�   2   x    2    P    r    L�   2   OJ   b   O,   x    X   #�   J   J�  A    R   #�   q   #   I    P    r   L�   P    L
  u+   P    L	   P    L
  u:   C   T+  L
  u:   C    F8  N  P   P    L  P    L
  u+   1    uN   M   O]   J9  i    X   #  R    #  q   #  I    1    P    P    L  M    #  A    R   #  q   #  I    P    L   P    A   C   #  FZ  A    uV   P    c<   P    M    #  R    #  q   #  I   P    L�   P    P    L�   M    #   L
  u   #!  Fo  L   P    c=   C   #!  L
  1   U9   #"  L
  1   U   ##  L
  P    L   1   C   F  A   J�  i    U:   #$  L
  P    U6   #%  L
  P   U7   #&  L
  P    P   p   U!   #'  L
  P    L
  P    L
  P    L
  P    L
  P    L
  P    L
  P    L
  P    P    p   U$   UC   U&   U"   U#   U   S�   S�   U    U   #(  L   P�  C   #)  L
  P    L
  P    p   U   U   #*  L
  P    P   p   U   #+  L
  P    P   p   U   #,  i    0    #-  0    P    i   P   0    P    4    P   @����J�  L
  r   u!   2    P    P    p   X   #-  L
  r   u   2    P    N�   P    P    L�   M    O]   X   #-  J�  i    0    #.  0    P    i   P   0    P    4    P   @����J  L
  r   u   2    P    N�   P   P    L�   M    O]   X   #.  J�  L
  P    P   p   U4   #/  L
  P    P   p   U5   #0  L
  P    L
  P    L
  P    L
  P    L
  P����U/   UA   UB   U?   U@   #1  L
  P    L
  P    U   UD   #2  L
  P    L
  P   P    L
  m    U;   #3  L
  P   P    L
  M    #4  L   P    L    C    P    c>   C   P    i����O�   #5  FO  L
  P   U(   #6  L   P    L
  u(   P    L    C    C   #7  L
  u(   P    i   O}   #9  F[  L   P    c?   C   #9  R    #:  q   #@  I    P    L	   P    L
  u   C   #A  Fq  L
  P    L   P    P   P   C   U   #A  L	   P    A   C   O^   #B  F}  L   P    c@   C   #B  L
  u(   P    i����O}   #C  F�  A   #D  P    J�  J�  -    d   P    O{   F�  L   P    cA   C   #E  J�  -    d   P   O{   F�  L   P    cB   C   #F  J�  -    d   P   O{   F�  L   P    cC   C   #G  J�  -    P    L   P    cD   C   #H  J�  -    L
  r   u   O�   P    X   #J  L
  r   u   1   P   X   #K  R    #L  q   #R  I    P    L
  P    L   1   C   F�  L   1   P    L
  u
   P   C   J�  A   UE   #S  L
  P    L
  uE   P    l   OQ   UG   #T  L
  P    UF   #U  R    #V  q   #\  I   P    L
  u   #]  F�  L   P    cE   C   #]  L    P   P   C   b   L    C    b   #^  L   P    B   P    c>   C   P    i����O�   #_  F	  L
  P   U(   #_  L
  r    u   P    i    x    P    c,   P    m    O^   #`  F+	  L   P    cF   C   #a  L
  P    P    L
  P    N�   P    P    L�   M    O]   M   #b  L
  r    u   P    x    P    cG   P    0    i    n3	  #d  L
  r    u   P    x    P    cH   P    0    L
  r    u   P    x    P    c,   P    m    P   OY   n?	  #e  i   b    i    b   L
  P    p   U   L
  r    u   P   x    P    cG   P    0    i    n]	  #f  B    P    i   O   Tk	  J�
  B    OJ   b    Ja	  B    P    i   O}   #g  F�	  L
  r    u   2    x    P    cG   P    0    L
  r    u   2    P   OY   x    P    cH   P    m    P   Oc   ny	  #g  L
  r    u!   P    B    x    f�   O^   #h  F�	  B    P    i   O{   #i  F�	  L   P    cI   C   #j  L
  P   P    L
  P    M   #k  J�	  B    P    i   O{   #m  F�	  L
  P   P    L
  P   P    N�   P   P    L�   P    cJ   P   M   O]   M   #m  J�	  B    P    i   O{   #n  F�	  L
  P   P    L
  P   P    N�   P    P    L�   P    cK   P   M   O]   M   #n  J�	  L
  P   P    L
  2    P    N�   P    P    L�   P    cL   P    L   P    cM   2    C   Oc   M   O]   M   #o  L
  r    u   2    x    P    cH   P    0    L
  r    u   2    x    P    cG   P    m    P    L
  r    u   2    x    P    c,   P    m    Oc   P   OY   n�	  #q  i    b   #r  B   P    L
  r    u!   P    B    x    f�   O   T$
  J�
  B   OJ   b   B   OJ   b   J
  L
  r    u!   2    x    2   x    P    c   P    0    B   n.
  #s  L
  d   u   P    L
  r    u!   2    x    2   x    Ou   U   #t  L
  r    u!   2    x    2   x    P    c1   P    m    P    P ���L   P   P    L
  r    u!   2    x    2   x    P    c1   P    m    f�   P   OY   C   O(   x    b   #u  L   P    L
  r    u!   P    B    x    P    B   x    b   P    c   C   #v  F�
  B   P    c   P    m    P    c   P    r   m    2   P    cN   P    m    2   X   #w  L
  d   u"   2   Ou   U"   #x  L
  d   u&   P    L
  u    Ou   U&   #y  J
  L
  d   u   P    L
  r    u   2    x    P    c   P    m    Ou   U   #{  Jg	  L
  P   U   #}  L
  P    P   p   U3   #~  L�   P    L
  u   f�   U   #  L�   P    L
  u   U   #�  L�   P   U    #�  L
  r    u   P    x    P    cO   P    M    #�  L
  r    u   P   x    P    cP   P    P    cQ   P   M   #�  L
  r    u   P   x    P    cP   P    P    cR   P   M   #�  L
  r    u   P   x    P    cP   P    P    cS   P   M   #�  L
  r    u   P   x    P    cP   P    P    cT   P   M   #�  L
  r    u   P   x    P    cP   P    P    cU   P    M   #�  L
  r    u   P   x    P    cP   P    P    cV   P    M   #�  L
  r    u   P   x    P    cP   P    P    cW   P   M   #�  L
  r    u   P	   x    P    cP   P    P    cX   P    M   #�  L
  r    u   P
   x    P    cP   P    P    cY   P    M   #�  L
  r    u   P   x    P    cP   P    P    cZ   P    M   #�  L
  r    u   P   x    P    cP   P    P    c[   P    M   #�  L
  P    L
  r    u   P   x    P    c-   P    m    U   #�  L
  P    L
  r    u   P	   x    P    c-   P    m    U   #�  L
  P    L
  r    u   P
   x    P    c-   P    m    U   #�  L
  P    L
  u   f�   U   #�  L
  P    L
  u   f�   U   #�  L
  P    L
  u   f�   U   #�  i   b   L
  P    L    P   P    L
  u   C   U   #�  B   P    i   O   T�  J�  B   OJ   b   J�  L
  d   u   P    L
  r    u   2   x    P    c\   P    m    Ou   U   #�  J�  L
  P    P    L
  u   f�   P   p   U.   #�  L
  P    L
  u   O"   U   #�  L
  P    c]   U   #�  L
  P    L
  u   O"   U   #�  L
  P    L   P    L
  u   P   C   O"   U   #�  L
  u   #�  F  L   P    L
  u	   P    c^   C   #�  F�  L   P    c_   C   #�  L
  P    L   P����P    L
  u
   P   C   U1   #�  L
  u   T  L
  P    L
  u	   P    c`   P    m    U   #�  F  L
  P    p   U   #�  L
  P    L
  P    U2   U   #�  P    L
  r    u   P   x    P    c-   P    m    p   S�   #�  L
  P    L   C    U%   #�  L
  u(   P    i����O}   #�  F  L   P    ca   C   #�  L   P    cb   P   P    L
  r    u   P   x    P    c,   P    m    O[   P    cL   C   b	   #�  L   P    cb   P   P    L
  r    u   P   x    P    c,   P    m    O[   P    cL   C   b
   #�  L   P    cb   P   P    L
  r    u   P   x    P    c,   P    m    O[   P    cL   C   b   #�  L   P    cb   P   P    L
  r    u   P   x    P    c,   P    m    O[   P    cL   C   b   #�  L   P    cc   P    L
  u   P    cd   P    r    Lb   P    L
  u   x    C   #�  L   P    ce   P    cf   P    cg   2	   P    ch   2
   P    ci   2   P    cj   2   P    ck   P    cl   P    P    p   P    cm   Og   Ou   P    cn   P    co   P    cp   P    L
  u"   P    L
  u   Os   C   #�  i    0    #�  0    P    L
  u   f�   P   0    P    4   P   @����J$  L   P    L
  r    u   P    B   x    P    cq   C   O^   F�  L   P    L
  r    u   P    B   x    P    c!   C   O^   #�  F#  r   B   P    L   P    L
  r    u   2   x    P    cr   C   F  i    J  L   P    L
  r    u   2   x    P    cs   C   F  i   J  L   P    L
  r    u   2   x    P    ct   C   F  i   J  i   d   x    OJ   X   #�  J�  L   P    cu   P    cl   P    P    p   P    cv   Og   Ou   P    cp   P    P    p   P    cr   Og   Ou   P    cs   Og   Ou   P    c   Og   Ou   P    ct   Og   Ou   P    cn   P    P    p   P    cw   Og   Ou   P    cw   Og   Ou   P    cw   Og   Ou   2   C   #�  L   P    cx   P    cp   P    P    p   P    c   Og   Ou   P    cl   P    P    p   P    cy   Og   Ou   P    cz   Og   Ou   P    c{   Og   Ou   P    c|   Og   Ou   P    c}   Og   Ou   P    c~   Og   Ou   P    c   Og   Ou   P    c�   Og   Ou   P    c�   Og   Ou   P    cn   P    P    p   P    c�   Og   Ou   P    L
  r    u   P   x    P    c-   P    m    P    L
  r    u   P   x    P    c-   P    m    Ou   P    L
  r    u   P   x    P    c-   P    m    Ou   P    L
  r    u!   P   x    P    x    P    c   P    m    Ou   P    L
  r    u   P   x    P    c-   P    m    Ou   P    L
  r    u   P   x    P    c-   P    m    Ou   P    L
  u   Ou   P    L
  u   Ou   P    L
  r    u   P   x    P    c-   P    m    Ou   C   #�  L   P    c�   P    L
  u   P    c�   C   #�  L   P    cl   P    P    p   P    c�   Og   Ou   P    cn   P    co   P    cp   P    L
  u#   P    L
  u   Os   C   #�  N  P    P    L  M    O]   b   #�  &    B   P    P    P    P    O�   M    O/   #�  L
  u   F)  L
  u2   #�  F0  L   P    c�   C   #�  L
  P    L
  u   f�   U   #�  N  P    P    L  M    O]   b   #�  &    B   P    P    P    P    O�   M    O/   #�  L
  P    L   P    L
  u   C   U   #�  L
  u   #�  Fc  L
  P    L
  u   f�   P   OY   P    L
  u1   OY   U1   #�  L
  P    L
  r    u   P   x    P    c-   P    m    P   OY   UK   #�  L	   P    L
  uA   C   #�  F�  L
  P    N�   P   P    L�   P    M   O]   UA   #�  L  P    P    L  M    #�  L
  r    u   P   x    P    c6   P    m    b   #�  L
  r    u   P   x    P    c7   P    m    b   #�  L
  P    L
  r    u   2   2   O(   x    P   OY   P   O0   UH   #�  L
  P    L
  r    u   P   x    2   2   O(   x    P    L
  uH   O[   UI   #�  L
  P    L
  r    u   P   x    2   2   O(   x    P    L
  uH   O[   UJ   #�  L
  P    P   P    L
  r    u   P   x    P    c-   P    m    p   U=   #�  L
  u(   P    i����O}   #�  F  L   P    c�   P    cp   P    P    p   P    c   Og   Ou   P    cl   P    P    p   P    c�   Og   Ou   P    c�   Og   Ou   P    cn   P    P    p   P    c�   Og   Ou   P    L
  u   P    L
  u2   Ou   C   #�  L   P    c�   C   #�  L   P    c�   P    c�   C   b   #�  i    0    #�  0    P    L
  u   P   0    P    4   P   @����J=  B   P    L   P    c�   P    c�   2   P    c�   C   OF   b   #�  J*  L   2   C   #�  i    b   #�  i    0    #�  0    P    L
  u   P   0    P    4   P   @����J�  i    b   c�   b   #�  B   P    L
  u   O   Tb  Jt  B   OJ   b   JW  B   P    L   P    c�   P    L
  r    u   2   x    2   x    C   OF   b   #�  J^  B   P    c�   OF   b   #�  i    b   #�  B   P    i   P    L
  u   OY   O   T�  J�  B   OJ   b   J}  B   P    c�   OF   b   #�  J�  i    b   #�  i    0    #�  0    P    L
  u   P   0    P    4   P   @����J�  B   P    L
  r    u   2   x    2   x    F�  c�   J�  c�   OF   b   #�  B   T�  L
  r    u   2   x    F�  L
  r    u   2   x    2   x    b   #�  J�  B   #�  F�  L   2   C   #�  J�  B   OJ   b   #�  JN  i    b   c�   b   #�  B   P    L
  u   O   T�  J�  B   OJ   b   J�  B   P    L   P    c�   P    L
  r    u   2   x    C   OF   b   #�  J�  L   2   P    c�   C   #�  B   #�  F  L   P    c�   2   C   #�  5   5   L
  P    N  P    P    L  M    O]   U>   #�  R    #�  q   #�  I    1    P    L    P    L
  u   C   UN   #�  A    P����UO   #�  A    P���UT   #�  A    R   #�  q   #�  I    1    r   uN   1    uL   1    uM   O(   P    L
  r    u   1    uL   1    uM   O(   x    P   OY   X   #�  R    #�  q   #�  I    1    P   P    L  M    #�  A    P    L
  r    u   P   x    P    cG   P    m    UL   #�  A    P    L
  r    u   P   x    P    cG   P    m    UM   #�  A    P   UO   #�  A    P    c;   P    M    #�  A    R   #�  q   #  I   P    L
  r    u.   P   x    b   #  L   P    r   L�   P    B   P    L
  u9   C    X   b    P    c�   C   #  F�  L
  d   u   OJ   U   #  B    P    c�   P    1    uN   M   #  L	   P    L
  u   C   O^   #  F�  L
  u   F�  L
  r    u1   P    L
  u0   x    P    i    O   #  F�  L
  r   u1   P    L
  u0   P    L
  u   f�   X   #  L
  d   u   2   Ou   U   #  R    #  q   #  I    1    1    P    UP   US   #  L	   P    A    uN   C   #  F�  A    P    L
  u   P   OY   UN   #  J�  A    P   P    L  M    #  A    P   P    L  P    P    L
  u   f�   P   OY   M   #  A    1    uL   P   Oc   UQ   #  A    r   uN   1    uL   1    uQ   P   OY   O(   P    L
  r    u   1    uL   1    uQ   P   OY   O(   x    P   OY   X   #  A    P   P    L  1    uL   1    uQ   P   OY   M   #  A    P   P    L  1    uL   1    uL   M   #  L
  r   u.   O�   P    L
  u   1    uN   O[   X   #  A    P    c9   P    P    r    L�   P    L
  r    u.   P   x    x    M   #  A    d   uP   OJ   UP   #  A    r   uN   P    A    uL   d   x    O,   X   P    i    O|   #   T   A    r   uN   1    uL   P    X   #!  A    P   P    L  1    uL   1    uL   M   #"  A    1    uL   P    L   1    r    uN   1    uL   1    uM   O(   x    P   Ou   C   O9   Oc   UQ   ##  A    uQ   P    A    uM   O   #$  F�  A    r   uN   1    uQ   d   x    O,   X   #%  A    P   P    L  1    uQ   1    uQ   M   #&  J�  A    P    c�   P    M    #(  A    uQ   P    A    uM   O~   T�  A    uR   O^   #)  T�  R    #*  q   #1  I    1    1    r    uN   1    uM   x    O^   UR   #2  A    d   uS   OJ   US   #3  A    uR   O^   #4  F�  A    r   uN   1    uM   d   x    O,   X   #4  A    P   P    L  1    uM   1    uM   M   #4  A    uR   #5  R   #5  R    #6  q   #@  I   P    L   C    b    L
  u   f�   P   OY   b   A    uL   F  A    r    uN   P    1    uL   P   OY   O(   x    J  p   b   A    uM   P    L
  u   P   OY   O   F  A    r    uN   1    uM   P   Oc   P ���O(   x    J  p   b   #E  A    1    P    UP   US   #F  A    P   P    L  P    P    L
  u   P   OY   M   #G  L	   P    A   C   #H  Fm  L
  u   b
   #I  A   P    i����O{   #J  FD  B   b   b   #K  i    b   #K  Jl  L
  r    u1   1   x    b   b   #N  B    f�   F[  L
  r    u1   P    r    B    P    x    x    P   Oc   Jj  A   P    O}   Fi  L
  r    u1   1   P   OY   x    P   Oc   Jj  i    b   #P  J�  A   b
   #T  B    f�   #U  F�  r    B    P    x    P    x    b   b   #V  r    B    P    x    P   x    b   #W  J�  B
   f�   b   b   #Z  i    b   #Z  A    P    UR   #]  A    r    uN   1    uM   x    b   #_  B   P    L~   P    r    B
   2   x    P    L
  r    u   P   x    O�   x    C   1    uL   1    uM   O(   x    Ou   2   Ou   b	   #`  B   P    B   O   F�  r    B	   P    A    uM   x    P    B   O   #a  F�  A    P    c�   P    M    #a  A    2	   UN   #b  A    P   P    L  1    uL   1    uM   M   #c  L
  r   u.   O�   P    L
  u   1    uN   O[   X   #d  A    P    c9   P    P    r    L�   P    L
  r    u.   P   x    x    M   #e  A    d   uP   OJ   UP   #f  B   O,   b   P    B   O|   #g  T�  A    uR   O^   #h  F  A    P    c�   P    M    #h  R    #i  q   #n  I   P    L
  u   #o  F8  L   C    b    #p  B    f�   O^   #q  F*  A    P    c�   P    1   M   #q  J6  A    P    c�   P    1   P    r    B    P    x    M   #q  5    J>  A    P    c;   P    M    #t  R    #u  q   #z  I    P    R    #z  q   #�  I   P    L
  r    u   P   x    P    c,   P    m    P   OY   b   i    b   i   b   L
  r    u   P   x    P    c\   P    m    b	   #�  L
  r   u4   2   P    c�   X   #�  L
  r   u5   2   P    c�   X   #�  L
  r   u4   2   P    p   X   #�  L
  r   u5   2   P    p   X   #�  L
  r    u   2   x    b   #�  L   P    B   P    c   C   #�  F�  B   P    c   P    m    P    c   P    m    b    #�  B   P    c   P    m    b   #�  J�  i   b    #�  B   b   #�  J�  B
   v    b   B
   v   b   J�  B   P    c�   P    P    c�   M   b
   J�  i    b
   #�  r    B	   2   P    c   P    m    2    OY   P   Oc   2   P    c   P    m    O(   x    2   O[   b   #�  i    b   #�  r    B   P    B   x    #�  F  L
  r   u4   2   d   x    P    L
  r    u4   2   x    P    r    B   2   x    Oc   OF   X   #�  L
  r   u5   2   d   x    P    L
  r    u5   2   x    P    r    B   2   x    O[   OF   X   #�  B   OJ   b   P    B   f�   O   #�  T�  B   b   #�  B   O^   b   #�  B   2    OY   b   #�  5
   B   P    i    O|   #�  Tu  L
  r   u3   P    P    L
  r    u4   2   x    O�   x    X   #�  L
  r   u3   P   P    L
  r    u5   2   x    O�   x    Os   X   #�  L
  u(   P    i   O}   #�  F^  N  P    P    L  M    O]   b   #�  &    B   P    P    P    P    O�   M    O/   #�  5   R    #�  q   #�  I    1    P   P    L  M    #�  A    P    L
  r    u   P   x    P    cG   P    m    UL   #�  A    P    L
  r    u   P   x    P    cH   P    m    UM   #�  A    P    p   UU   #�  A    P    c;   P    M    #�  L   P    c�   P    cp   P    P    p   P    c�   Og   Ou   P    L
  r    u"   P    L
  r    u   P   x    P    cG   P    m    P ���L
  r    u   P   x    P    cH   P    m    O(   x    Ou   P    c�   Ou   P    cn   P    L
  r    u&   P    x    O"   P    L
  r    u&   P   P    L
  r    u   P   x    P    cG   P    m    Oc   P   P    L
  r    u   P   x    P    cH   P    m    Oc   O(   x    Ou   P    c�   Ou   1    uU   C   #�  A    &    uU   P    P    P    P    O�   M    O/   #�  A    R   #�  q   #�  I   P    L
  r    u.   P   x    b    #�  A    d   uU   2    1    r    uN   1    uL   1    uM   O(   x    Os   OF   P    L
  r    u3   P   x    2    x    OF   Ou   UU   #�  R    #�  q   #�  I    P    L}   P    L
  1   U/   C   #�  R   #�  R    #�  q   #�  I   1   b    #�  B    P    A   O~   T<  J�  B    OJ   b    J2  L
  r    u   2    x    b   #�  B   P    c8   P    0    A    r    uN   2    x    nG  b   #�  L   P    L
  r    u   P    B    x    P    c   C   #�  F�  B   P    c   P    m    P    c8   P    r   m    2   P    cN   P    m    2   X   #�  B   P    i   Ot   O}   #�  F�  B   P    c   P    m    P    c�   P    r   m    2   P    cN   P    m    2   P    c�   P    m    r    2   x    X   #�  J8  L
  P    L  P   P    L
  M    U0   #�  B   #�  R   #�  R    #�  q   #�  I   P    b    #�  B    P    L
  r    u   P    i    x    P    c,   P    m    O   T�  J�  B    OJ   b    J�  L
  r    u!   P    x    2    x    P    c8   P    0    r    A   2    x    n�  #�  J�  R    #�  q   #�  I   P    L   P    L
  u	   C   #�  F�  L   P    c�   C   #�  L   C    b    #�  L   P    A   P    c�   C   #�  F�  L
  1   U	   #�  L
  P	   U   #�  J�  L
  1   U   #�  L
  u   #�  P    J�  J�  -    d   P   O{   F  L
  P    N�   P   P    L�   P   M   O]   U	   #�  J�  #�  J  -    d   P    O{   F!  L
  P    N�   P   P    L�   P    M   O]   U	   #�  J�  #�  J&  -    d   P   O{   F8  L
  P    N�   P    P    L�   P    r    B    P    x    M   O]   U	   #�  J�  #�  J=  -    d   P   O{   FJ  L
  P    N�   P    P    L�   M    O]   U	   #�  J�  #�  JO  -    d   P   O{   Fa  L
  P    N�   P    P    L�   P    r    B    P    x    M   O]   U	   #�  J�  #�  Jf  -    d   P   O{   F}  L
  P    N�   P    P    L�   P    r    B    P    x    P    r    B    P   x    M   O]   U	   #�  J�  #�  J�  -    d   P   O{   F�  L
  P    N�   P   P    L�   P    r    B    P    x    P    r    B    P   x    M   O]   U	   #�  J�  #�  J�  -    d   P   O{   F�  L   P    c�   C   #�  J�  #�  J�  -    d   P   O{   F�  L
  P    N�   P    P    L�   P    r    B    P    x    P   M   O]   U	   #�  J�  #�  J�  -    L
  P   P    L
  P   P    L
  u	   M   #  L
  P    L
  u	   P    c�   P    m    P    c   P    m    U
   #  R    #  q   #	  I    P    L
  u	   P    c�   P    M    #	  R   #	  R    #	  q   #  I    P    R    #  q   #  I   P    L
  P   U   #  L
  u;   C    #  i    b    #  L
  P    i   P    L
  P    L
  r    u   P    B    x    M   #!  FH  L
  r    u   2    x    P    c   P    m    P    c�   P    M    #"  L   P    L
  r    u   P    B    x    P    c   C   ##  F5  L
  r    u   2    x    P    c   P    m    P    c�   P    M    #$  B    P    L
  r    u   2    x    P    c   P    m    P    c   P    m    Oc   b    #%  Jm  L
  r    u   2    x    P    c�   P    M    #(  L   P    L
  r    u   P    B    x    P    c$   C   #)  Fi  L
  r    u   2    x    P    c�   P    M    #*  B    OJ   b    #+  B    P    L
  u   f�   O   #-  T�  i    b    #.  B    P    L
  r    u   P    i    x    f�   O   T�  J�  B    OJ   b    Jx  L
  r    u   P    x    2    x    P    c�   P    M    #/  B    O^   #0  F�  L
  r   u   P    P    L
  r    u   P    x    2    x    P    c�   P    m    X   #0  J�  L
  r    u   P    x    f�   b   #2  L
  r   u   P    d   x    P    L   P    L
  r    u   P    x    P    L
  r    u   P    x    2    x    P    c   P    m    P   OY   2   O[   2    C   Ou   X   #3  L
  r   u   P    d   x    P    L   P    L
  r    u   P    x    2    x    P    c�   P    m    P    L   P   2   C   O[   C   OF   X   #4  J�  i   0    #7  0    P    L
  u   P   0    P    4    P   @����J  L
  r   u   2    x    O�   x    O�   P    L   P    L
  r    u   P    x    P    L
  r    u   2    x    C   X   #7  J�  L
  P    L   C    U%   #8  L
  P
   P    L
  M    #9  L	   P    A   C   O^   #:  F9  L
  u>   P    c�   P    0    A   n5  #:  L
  u>   P    c�   P    0    L
  u>   P    c�   P    0    i   nD  n>  #;  L
  u>   P    c�   P    P����M   #<  L
  u(   P    i    O}   #=  Fd  L   P    c�   P    L   C    P    L
  u%   OY   C   #=  R    #>  q   #C  I    1    P    P    L  M    #C  A    R   #C  q   #H  I    1   P    c�   P    M    #H  R    #H  q   #N  I    P    L
  u	   P    c�   P    m    P    c8   P    m    #N  R   #N  R    #N  q   #P  I    1    P   P    L  M    #Q  A    P    L
  r    u   P   x    P    cG   P    m    UL   #R  A    P    L
  r    u   P   x    P    cG   P    m    UM   #S  A    R   #T  q   #V  I    1    P   P    L  M    #W  A    P    L
  r    u   P   x    P    cG   P    m    UL   #X  A    P    L
  r    u   P   x    P    cH   P    m    UM   #Y  A    R   #Z  q   #_  I    P    L
  P    L
  u7   U6   #_  L
  P    L
  u7   O^   U7   #_  R    #_  q   #d  I   1    1   UT   #e  A    1   UQ   #f  A    P    L
  r    u.   P	   x    US   #g  A    P    L
  r    u.   P
   x    UR   #h  L
  u   #i  FJ  L
  r    u   P   x    P    c-   P    m    b    #j  A    P    2    2    p   UU   #k  A    P    2    p   UW   #l  L	   P    L  uO   C   #m  FH  L  P    P    L
  u   P    L
  u   p   UO   #n  L  P   P    L    P    L
  u   P   OY   P   C   Ou   UP   #o  5    JP  A    1    P    UW   UU   #r  A    P    L
  u   Fe  P    L
  u   f�   P    L
  r    u   P   x    P    c-   P    m    p   Jf  i    UV   #s  A    P����UX   #t  A    R   #u  q   #z  I    P    L	   P    A    uU   C   O^   #{  F�  A    &    uU   P    P    P    P    O�   M    O/   A    uW   #{  A    1    P    UW   UU   #|  L	   P    A    uV   C   O^   #}  F�  A    &    uV   P    P    P    P    O�   M    O/   #}  A    P    UV   #~  L	   P    L  uO   C   O^   #  F�  L  &    uO   P    P    P    P    O�   M    O/   L  uP   #  L  P    L  P    UP   UO   #�  R    #�  q   #�  I   P    L
  r    u   P   x    P    c6   P    m    b    #�  B    P    L
  r    u   P    i   x    P    c7   P    m    O~   T�  J;  B    OJ   b    J�  L
  r    u   2    x    b   #�  B   P    c8   P    0    A    r    uT   2    x    n�  b   #�  L  P    i   P    L
  P    L
  r    u   P    B    x    M   #�  F:  B   P    c   P    m    P    c8   P    r   m    2   P    cN   P    m    2   X   #�  B   P    i   Ot   O}   #�  F:  B   P    c   P    m    P    c�   P    r   m    2   P    cN   P    m    2   P    c�   P    m    r    2   x    X   #�  J�  B   #�  R   #�  R    #�  q   #�  I    P    L  r   uO   O�   x    O�   1    r    uU   P    L
  u   x    P    L
  u   x    X   #�  L  P    L   P    L  uO   P    L   P    L  uO   P    l   OY   C   C   UO   #�  L  r   uO   P    x    O�   P    l   X   #�  L   P    L  uO   P    L  &    uL   P    L  &    uM   P    L  &    uN   C   #�  P    J�  J�  -    d   P    O{   F�  L   P    c�   1    uQ   C   #�  L   P    c�   C   #�  J�  #�  J�  -    d   P   O{   F�  L   P    c�   1    uQ   C   #�  L   P    c�   C   #�  J�  -    d   P   O{   F�  A    r   uW   O�   P    l    X   #�  A    r   uW   P    L
  u   P    L   P    L  uL   P    L  uM   P    L  uN   P    L  uP   C   X   #�  J�  #�  J�  -    R    #�  q   #�  I    P    L~   P    L   1    uW   C   P    L
  r    u   P   x    O�   x    C   #�  R   #�  R    #�  q   #�  I    1    P   P    L  M    #�  A    P
   UU   #�  A    P    L
  r    u   1    uU   x    P    c6   P    m    UL   #�  A    P    L
  r    u   1    uU   x    P    c7   P    m    UM   #�  A    R   #�  q   #�  I    1    P    L	   1   C   F2  L~   1   P    L
  r    u   P
   x    O�   x    C   J3  A   UN   #�  R    #�  q   #�  I    1    P   P    L  M    #�  A    P	   UU   #�  A    P    L
  r    u   1    uU   x    P    c6   P    m    UL   #�  A    P    L
  r    u   1    uU   x    P    c7   P    m    UM   #�  A    R   #�  q   #�  I   P    L
  P    l   U-   #�  L
  r    u   P   x    P    cH   P    m    b    #�  L   P    L
  r    u   P    B    x    P    c   C   #�  F�  L
  d   u-   P    L
  r    u   2    x    P    c   P    m    P    c�   P    m    O[   U-   #�  B    P    L
  r    u   2    x    P    c   P    m    P    c   P    m    OY   b    #�  J�  L
  d   u-   P    L
  r    u   2    x    P    c�   P    m    P    L}   P    L
  r    u   2    x    C   x    O[   U-   #�  B    O,   b    #�  B    P    L
  r    u   P    i   x    P    cG   P    m    O|   #�  Tw  L
  r   u,   1    uR   x    1    uS   P    L
  u-   X   #�  L
  u-   #�  R   #�  R    #�  q   #�  I    1    P    P    L  M    #�  A    R   #�  q   #�  I    1   P    c   P    M    #�  R    #�  q   #�  I   P    N  P   P    L  1   1   1   M   O]   b    #�  A   #�  F  L   P    c�   P    L  uU   C   #�  B    P    c�   P    P����M   #�  A   #�  F/  L   P    L  uU   P    c�   C   #�  &    B    P    P    P    P    O�   M    O/   #�  R    #�  q   #�  I    P    L   P   P   O[   C   #�  L  P    L
  r    u&   P    P   O(   x    P    L
  r    u&   P   P    L
  r    u   P   x    P    cG   P    m    Oc   P   P    L
  r    u   P   x    P    cG   P    m    Oc   O(   x    Ou   P    c�   Ou   P    c�   Ou   UV   #�  L  P    P    p   P    c�   Og   Ou   P    c�   Og   Ou   P    c�   Og   Ou   P    L
  r    u"   P    L
  r    u   P   x    P    cG   P    m    P ���L
  r    u   P   x    P    cG   P    m    O(   x    Ou   P    c�   Ou   P    c�   Ou   U[   #�  R    #�  q   #  I    1    P   P    L  M    #  A    P    L
  r    u   P   x    P    cG   P    m    UL   #  A    P    L
  r    u   P   x    P    cG   P    m    UM   #  A    P   UO   #  A    1   U\   #  L  1   UZ   #  L  P    L  u[   1   F�  P    p   P    c�   P    c�   Ou   P    c�   Ou   Og   Ou   J�  c�   Ou   UY   #  L  P    L  uV   1   F�  c�   P    c�   Ou   J�  c�   Ou   UW   #	  L	   P    A   C   #
  F
  A    P    U]   #  J  A    1   U]   #  A    r   u]   P    P    p   X   #  A    P    U`   #  A    R   #  q   #  I   P    L   P    A   P    c�   C   O^   #  F-  #  R    #  A    1   P    c�   P    m    r    P   x    1   P    c�   P    m    OF   1   P    c   P    m    OF   1    r    uN   P    L
  r    u   P   x    P    cG   P    m    P ���L
  r    u   P   x    P    cG   P    m    O(   x    Os   OF   U_   #  A    P    U^   #  A    u^   P    A   P    c�   P    m    f�   O   Tu  J  A    d   u^   OJ   U^   Jc  A   P    c�   P    1    u^   M   b   #  A    1    u_   1    u^   OF   1   P    c�   P    m    r    1    u^   x    OF   P    L  uZ   F�  L   2   C   b    O9   P    r    B   2    x    OF   P    L   2   C   OF   J�  B   Os   OF   Ua   #  L   P    A   P    c�   C   #  F�  A    d   ua   P    L}   1   P    c�   P    m    C   Os   OF   Ua   #  L	   P    A    u]   C   O^   #  F�  A    r   u]   P    d   x    1    ua   Ou   X   #  A    u\   #  F  A    1    u`   F�  L   P    cn   P    L  uW   1    ua   C   J�  L   P    cp   P    L  uY   P    cn   P    L  uW   1    ua   C   Ub   #  L   1    r    ub   P   P ���O(   x    C   #   A    P   U`   #!  Jo  R    #$     $ox$end 