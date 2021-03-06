//+------------------------------------------------------------------+
//|                                                      X-Trail.mq4 |
//|      Copyright 2017, Marco vd Heijden, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Marco vd Heijden, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

static input double trail=250;// Trail 
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetMillisecondTimer(500);

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
   for(int order=OrdersTotal(); order>=0; order--)
     {
      bool selected=OrderSelect(order,SELECT_BY_POS);
        {
         if(selected==1)
           {
            switch(OrderType())
              {
               case OP_BUY:
                 {
                  if(OrderStopLoss()==0)
                    {
                     bool modify=OrderModify(OrderTicket(),0,MarketInfo(OrderSymbol(),MODE_BID)-trail*Point(),0,0,clrNONE);
                    }
                  if(MarketInfo(OrderSymbol(),MODE_BID)-trail*Point()>OrderStopLoss())
                    {
                     bool modify=OrderModify(OrderTicket(),0,MarketInfo(OrderSymbol(),MODE_BID)-trail*Point(),0,0,clrNONE);
                    }
                 }
               break;

               case OP_SELL:
                 {
                  if(OrderStopLoss()==0)
                    {
                     bool modify=OrderModify(OrderTicket(),0,MarketInfo(OrderSymbol(),MODE_ASK)+trail*Point(),0,0,clrNONE);
                    }
                  if(MarketInfo(OrderSymbol(),MODE_ASK)+trail*Point()<OrderStopLoss())
                    {
                     bool modify=OrderModify(OrderTicket(),0,MarketInfo(OrderSymbol(),MODE_ASK)+trail*Point(),0,0,clrNONE);
                    }
                 }
               break;
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
