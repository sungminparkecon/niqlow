Ox0700                             $ox$info        $ox$end    $ox$literals 
                       Shared      AuxiliaryValues.ox      zeta      U      Utility      ialpha      L      N      vals    $ox$end    $ox$symbols |      constant 0�          cc$constant           dval       r        d          d         d         d         d         d         d         d  @       d          d         d         d  ����    d          d         d         d         d  -DT�!	@    d  -DT�!@    d  -DT�!�?    d  ���m0_�?    d  '��@    d  iW�
�@    d  �o��x�?    d        �    d        �    d        �    d        ��    d         d        �<    d  5       d  �������    d            d  ���    d  �      d  >���    d  �      d  ����    d  4      d  ���    d        ��    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d  ����    d          d         d         d  ����    d          d         d         d         d          d         d         d         d         d         d         d         d         d  	       d  
       d  
         Infinite Horizon       Ergodic       Normal Finite Horizon Aging    '   Static Program (finite horizon and T=1)    K   Random Aging (finite horizon but aging happens with probability<1 at some t    X   Random Mortaility (finite horizon with probability of early transition to last t, death)    J   Uncertain Longevity (finite horizon until last period which ends randomly)       Regime Change       Social Experiment       User Defined Clock     d          d         d         d          d         d         d         d         d         d         d          d         d         d         d          d         d         d          d         d         d         d         d           sample size       mean       st.dev.       min       max     d  :�0�yE>    d  :�0�yE>    d  �h㈵��>    d  -C��6?   CV 0�            $CV           X    
   Zauxiliary        ����       Discretized       �  
   Zauxiliary    nodes $	        N  	        lt  	        av  	        m  	        z  	        ff  	        nxtp  	        nxtf  	        i  	        indx  	        np  	        pts  	        f  	        p  	           Approx 0           cc  $Approx           this       $t0       x       trans       Discretized 0           cc $Discretized           this       $t0       nodes       Quantity       ����   L $	        pos  	        v  	            Discrete       �     Quantity    L $	        pos  	        v  	        vals $	        subv  	        N  	        actual  	        pdf  	           Discrete 0           cc  $Discrete           this       $t0       L       N       PDF 0           cc$PDF           this       $t0       Update 0        	   cc$Update           this       $t0    	   Parameter       �     Quantity    L $	        pos  	        v  	        NearFlat $ -C��6?   sep $         DoNotConstrain          ival $	     	   DoNotVary  	        f  	        block  	        start  	        scale  	           Decode 0        
   cc $Decode           this       $t0       f       Encode 0        	   cc$Encode           this       $t0    	   Parameter 0           cc  $Parameter           this       $t0       L       ival       Reset 0        
   cc  $Reset           this       $t0       newv       IsCode       ToggleDoNotVary 0           cc$ToggleDoNotVary           this       $t0       Integration        �  
   Zauxiliary        GaussianQuadrature        �     Integration        GQL       �     GaussianQuadrature    nodes          wght          
   Initialize 0           cc $Initialize           this       $t0       order       GQH       �     GaussianQuadrature    order          nodes          wght          
   Initialize 0           cc $Initialize           this       $t0       order       coef 0           cc $coef           this       $t0       n       GHK       �     Integration    J $	        M $	        R $	        hR $	        iseed $	        SimJ $	        L  	        u  	        nu  	        pk  	        prob  	           GHK 0        	   cc   $GHK           this       $t0       R       J       iseed       SimDP 0        
   cc  $SimDP           this       $t0       V       Sigma       SimProb 0           cc   $SimProb           this       $t0       j       V       Sigma       Version       �  
   Zauxiliary    MinOxVersion $ �     version $ �      checked             Check 0           cc$Check           this       $t0    	   Equations       �  
   Zauxiliary    rlabels $          lamba       values    L $	        N $	        v  	        J  	        lam  	        	   Equations 0           cc $Equations           this       $t0       LorN       norm 0           cc$norm           this       $t0       penalty 0        
   cc$penalty           this       $t0       print 0           cc$print           this       $t0       Equality       �  	   Equations    rlabels $          lamba       values    L $	        N $	        v  	        J  	        lam  	           Equality 0           cc $Equality           this       $t0       LorN       print 0           cc$print           this       $t0    
   InEquality       �  	   Equations    rlabels $          lamba       values    L $	        N $	        v  	        J  	        lam  	        
   InEquality 0           cc $InEquality           this       $t0       LorN       print 0           cc$print           this       $t0       Point    	   �  
   Zauxiliary    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	           Copy 0           cc $Copy           this       $t0       h       GCopy 0        	   cc $GCopy           this       $t0       h       Point 0           cc$Point           this       $t0    	   aggregate 0           cc  $aggregate           this       $t0       V  @        v  @        SysPoint    	   �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	           SysPoint 0           cc$SysPoint           this       $t0       SepPoint       �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	        Kvar $	        bb $	           SepPoint 0           cc  $SepPoint           this       $t0       Kvar       bb    	   aggregate 0           cc  $aggregate           this       $t0       V  @        v  @        MixPoint       �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	        Dvar $	        sp $	        WF  	        W  	        mix  	           Copy 0           cc $Copy           this       $t0       h       MixPoint 0           cc  $MixPoint           this       $t0       Dvar       sp    	   aggregate 0           cc  $aggregate           this       $t0       V  @        v  @        CPoint       �     Point    AggType  	        F  	        X  	        V  	        v  	        J  	        G  	        H  	        SE  	        L  	        eq  	        ineq  	           CPoint 0           cc  $CPoint           this       $t0       e       i       Copy 0           cc $Copy           this       $t0       h       Vec 0           cc$Vec           this       $t0       AuxiliaryValues       �     Quantity    L $	        pos  	        v  	        N $	           AuxiliaryValues            cc  $AuxiliaryValues          this       $t0       L  @        N  @       Realize            cc  $Realize          this       $t0       q       y  @        RealizedUtility            AuxiliaryValues    L $	        pos  	        v  	        N $	           Realize      Y      cc  $Realize          this       $t0       q       y       RealizedUtility      J      cc$RealizedUtility          this       $t0    
   Indicators            AuxiliaryValues    L $	        pos  	        v  	        N $	        target $	            StateIndicators         
   Indicators    L $	        pos  	        v  	        N $	        target $	           Realize      �      cc  $Realize          this       $t0       q       y  @        StateIndicators      l      cc $StateIndicators          this       $t0       target       ActionIndicators         
   Indicators    L $	        pos  	        v  	        N $	        target $	           ActionIndicators 0           cc $ActionIndicators           this       $t0       target       Realize 0           cc  $Realize           this       $t0       q       y  @        ZetaRealization       �     Quantity    L $	        pos  	        v  	        length $	           Realize      D      cc  $Realize          this       $t0       q       y       ZetaRealization      +      cc $ZetaRealization          this       $t0       length       $ox$end 	   $ox$pcode �             q   #   I    1    1   U    #   A    1   U   #   A    P����U   #   A    P    L    P    p  P   1   C   U   #   A    R   #   q   #   I    1    r   u   O�   P    l    X   #   R    #   q   #   I    1    P    c   U    #   A    1   U   #   A    P    L    P    p  P   1   C   U   #   A    R   #    q   #&   I    P    R    #&   q   #)   I    1    P    P    Lv   P    c   P   M   #)   A    R   #)   q   #+   I    1    1   P    c   P    M    1   P    c   P    m    x    U   #+   R    #+   q   #-   I    1    1   U   #.   A    P    P    Lv   1   P    c   P    m    1   P    c   P    m    M   #/   A    R   #0   q   #2   I    1    r   u   O�   P    Lb   1    u   C   1    u   P    c	   P    m    O?   X   #3   R    #4      $ox$end 