# Welcome to the Ramirez Lab Wiki – Topological Protein-protein interactions (PPI) networks analysis

<div align="justify">Here we present a R-Studio pipeline to compute some topological parameters that will help us understand the "importancy" of each protein in a PPI network in terms of its connections. For further information about Topological PPI networks analysis go to EMBL-EBI online tutorial: <a href="https://www.ebi.ac.uk/training/online/courses/network-analysis-of-protein-interaction-data-an-introduction/network-analysis-in-biology/" target="_blank"><b>Network analysis of protein interaction data</b></a>.</div>
<div align="justify">Here we will use the PPI network for the Alzheimer's disease (PPI-AD) obteined in our group using KNIME, available <a href="https://github.com/ramirezlab/WIKI/tree/master/Computational_Polypharmacology/PPI-networks" target="_blank"><b>here</b></a>.</div>



## Requirements
+ R v4.1.1 or more recent.

The first step is installing in R the packages that are needed, as well as loading their respective libraries. In order to do this, you can copy and paste the following code in R and run it.

```R
    install.packages("ggplot2")
    install.packages("igraph")
    install.packages("ggraph")
    install.packages("ggvenn")
    install.packages("VennDiagram")
    install.packages("gplots")
    install.packages("UpSetR")
    install.packages("tidyverse")
    install.packages("readxl")


    library(igraph)
    library(ggplot2)
    library(ggraph)
    library(ggvenn)
    library(VennDiagram)
    library(gplots)
    library(UpSetR)
    library(readxl)
```

Now, that the libraries are loaded, we will define a multiplot function that is going to be used to visualize the network in our file.

```R
    multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
    library(grid)
  
    # Make a list from the ... arguments and plotlist
      plots <- c(list(...), plotlist)
  
      numPlots = length(plots)
  
     # If layout is NULL, then use 'cols' to determine layout
       if (is.null(layout)) {
        # Make the panel
        # ncol: Number of columns of plots
        # nrow: Number of rows needed, calculated from # of cols
        layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                      ncol = cols, nrow = ceiling(numPlots/cols))
        }
  
       if (numPlots==1) {
        print(plots[[1]])
    
      } else {
      # Set up the page
       grid.newpage()
       pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
       # Make each plot, in the correct location
       for (i in 1:numPlots) {
       # Get the i,j matrix positions of the regions that contain this subplot
       matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
         }
       }
     }
     ###################################################################
     normalize <- function(x) {                                        # 
       return ((x - min(x)) / (max(x) - min(x)))                 }     #
     ###################################################################
```

<div align="justify"> Once the multiplot function is defined, we are going to upload the file that has the proteins and the connections, this file is available online at RamirezLab GitHub (<a href="https://github.com/ramirezlab/WIKI/blob/master/Computational_Polypharmacology/PPI-network-R-TopologyAnalysis/input/02_output_Protein-Protein_Interaction_network.csv" target="_blank"><b>here</b></a>), which is why we are going to upload it from an URL and not from a saved file, but in case you want to analyze a local file you can uploaded it using a read.csv of read.xlsx command.</div>

```R
    Dat <- read_excel("your-file-location.xlsx")


    names(Dat)[1]<- "X";  
    names(Dat)[2]<- "Y"; 
    names(Dat)[3]<- "weight";
    Dat$weight <- as.numeric(Dat$weight)*100
    Dat$Prot_A <- NULL; Dat$Prot_B<-NULL
```

If you load the data correctly, the data frame looks like the following table, were each row is a connection between the two proteins in each column.

```R
    head(Dat, 5)
```


The next step is to create the Graph that we are going to analyze, after you run this segment of code you will obtain an image like the following one (Left). The same network could be also visualized in Cytoscape as reference (right graph).

```R
    library(igraph)
    g <- graph_from_data_frame(Dat, directed = FALSE)
    autograph(g)
```
 <img src=".\media\descarga.png" style="width:200px;" /> <img src=".\media\PPI-Blank_1.png" style="width:610px;" />


Now, to obtain more information about the resulting graph, such as data that can be used to calculate some topological parameters like degree, centrality, betweenness, Pagerank, and closeness.

```R
    print(paste("The Graph has",
            length(degree(g)),
            "vertex",
            nrow(Dat),
            "edges, and",
            length(g),
            "connected components"))

    dg <- decompose.graph(g)

    for (i in 1:length(dg))
     { 
       cg <- dg[[i]]
       print(paste("Component", i, "Size:", length(degree(cg)) ) )
     }
```

Next we compute the following indices of each vertex, we will normalize our values, that means we will put all our values between 0 and 1.


### Degree
<div align="justify">In graph theory, the degree of a vertex of a graph is the number of edges that are incident to the vertex. In a biological network, the degree may indicate the regulatory relevance of the node. Proteins with very high degree are interacting with several other signaling proteins, thus suggesting a central regulatory role, that is they are likely to be regulatory hubs. The degree could indicate a central role in amplification (kinases), diversification and turnover (small GTPases), signaling module assembly (docking proteins), gene expression (transcription factors), etc. (Scardoni et al. 2009).</div>

```R
    Vertex <- as.data.frame(degree(g))
    Vertex$Degree <- normalize(as.numeric(Vertex$`degree(g)`))
    Vertex$`degree(g)` <- NULL
```    

### Centrality
<div align="justify">Centrality or eigenvector centrality (also called prestige score) is a measure of the influence of a node in a network. Relative scores are assigned to all nodes in the network based on the concept that connections to high-scoring nodes contribute more to the score of the node in question than equal connections to low-scoring nodes. A high eigenvector score means that a node is connected to many nodes who themselves have high scores. Betweenness Centrality of a node in a protein signaling network, can indicate the relevance of a protein as functionally capable of holding together communicating proteins. The higher the value the higher the relevance of the protein as organizing regulatory molecules. Centrality of a protein indicates the capability of a protein to bring in communication distant proteins. In signaling modules, proteins with high Centrality are likely crucial to maintain the network’s functionality and coherence of signaling mechanisms (Scardoni et al. 2009).</div>


If **A** is the adjacency matrix of the graph **G** the relative centrality, <img src="https://render.githubusercontent.com/render/math?math=%24x_v%24">, score of vertex **v** can be defined as:
      
<img src="https://render.githubusercontent.com/render/math?math=%24%0Ax_v%20%3D%20%5Cfrac%7B1%7D%7B%5Clambda%7D%5Csum_%7Bt%5Cin%20M(v)%7Dx_t.%20%0A%24"  style="width:150px;" />

where **M(v)** is a set of the neighbors of **v** and <img src="https://render.githubusercontent.com/render/math?math=%24%5Clambda%24"> is a constant, in terms of the adjacency matrix this is <img src="https://render.githubusercontent.com/render/math?math=%24Ax%3D%5Clambda%20x%24">.

```R
    Vertex$Centrality <- eigen_centrality(g)$vector
```

### Betweenness


<div align="justify">The betweenness centrality (or "betweenness”) is a measure of centrality, for each vertex the betweenness is by definition the number of these shortest paths that pass through the vertex. For every pair of vertices in a connected graph, there exists at least one shortest path between the vertices such that the number of edges that the path passes through is minimized. The betweenness  centrality <img src="https://render.githubusercontent.com/render/math?math=%24b(v)%24"> of a node v is defined by:</div>

<img src="https://render.githubusercontent.com/render/math?math=%24%0Ab(v)%20%3D%20%5Csum_%7Bs%5Cne%20v%5Cne%20t%5Cin%20V%7D%5Cfrac%7B%5Csigma_%7Bst%7D(v)%7D%7B%5Csigma_%7Bst%7D%7D%0A%24"   style="width:150px;" />

Where <img src="https://render.githubusercontent.com/render/math?math=%24%5Csigma_%7Bst%7D%24"> is the total number of shortest paths from node **s** to node **t** and <img src="https://render.githubusercontent.com/render/math?math=%24%5Csigma_%7Bst%7D(v)%24"> is the number of those paths that pass through **v**.

```R
    Vertex$Betweenness <- normalize(betweenness(g, normalized = TRUE ))
```    

### Pagerank


<div align="justify">PageRank is an algorithm used by Google Search to rank web pages, it is a way of measuring the importance of website pages. According to Google: “PageRank works by counting the number and quality of links to a page to determine a rough estimate of how important the website is. The underlying assumption is that more important websites are likely to receive more links from other websites.” Page-rank allows an immediate evaluation of the regulatory relevance of the node. A protein with a very high Page-rank is a protein interacting with several important proteins, thus suggesting a central regulatory role. A protein with low Page-rank, can be considered a peripheral protein, interacting with few and not central proteins (Scardoni et al. 2009).</div>

```R
    Vertex$PageRank <- normalize(page_rank(g)$vector)
```

### Closeness


<div align="justify">Closeness centrality (or closeness) of a node is a measure of centrality in a network, calculated as the reciprocal of the sum of the length of the shortest paths between the node and all other nodes in the graph. A protein with high closeness, compared to the average closeness of the network, will be central to the regulation of other proteins but with some proteins not influenced by its activity. A signaling network with a very high average closeness is more likely to be organized in functional units or modules, whereas a signaling network with very low average closeness will behave more likely as an open cluster of proteins connecting different regulatory modules (Scardoni et al. 2009). The equation for closeness is:</div>

<img src="https://render.githubusercontent.com/render/math?math=%24%0AC(x)%20%3D%20%5Cfrac%7B1%7D%7B%5Csum_y%20d(x%2Cy)%7D%0A%24"   style="width:150px;" />

Where <img src="https://render.githubusercontent.com/render/math?math=%24d(x%2Cy)%24"> is the distance between the vertices **x,y**. A high closeness can be thought of as an easy access to all nodes. 

```R
    Vertex$Closeness <- normalize(closeness(g))
```

Next we classify the vertex with values over the 50%, and save a copy of the original vertex

```R
    Vertex$N <- c(1:length(Vertex$Degree))
    Vertex$DegreeCat <- ifelse(Vertex$Degree < 0.5, "no", "yes")
    Vertex$CentralityCat <- ifelse(Vertex$Centrality < 0.5, "no", "yes")
    Vertex$BetweennessCat <- ifelse(Vertex$Betweenness < 0.5, "no", "yes")
    Vertex$PageRankCat <- ifelse(Vertex$PageRank < 0.5, "no", "yes")
    Vertex$ClosenessCat <- ifelse(Vertex$Closeness < 0.5, "no", "yes")

    V_Original <- Vertex


    Best_Degree <- as.list(as.character(row.names(Vertex[Vertex$DegreeCat == "yes",])))
    Best_Closeness <- as.list(as.character(row.names(Vertex[Vertex$ClosenessCat == "yes",])))
    Best_Centrality <- as.list(as.character(row.names(Vertex[Vertex$CentralityCat == "yes",])))
    Best_Betweenness <- as.list(as.character(row.names(Vertex[Vertex$BetweennessCat == "yes",])))
    Best_PageRank <- as.list(as.character(row.names(Vertex[Vertex$PageRankCat == "yes",])))
```

The final table for our vertex looks like this:

```R
    head(Vertex, 5)
```

Let's see the behavior of all the topological index that we have

```R
    library("tidyverse")
    Vertex <- Vertex[order(Vertex$Degree, decreasing = FALSE), ]
    Vertex$N <- c(1:nrow(Vertex) )
    df <- Vertex %>%
      select(N, Degree, Betweenness, Centrality, PageRank, Closeness) %>%
      gather(key = "variable", value = "value", -N)

    ggplot(df, aes(x = N, y = value)) + 
      geom_point(aes(color = variable), size=0.5)  +
      labs(title="All variables")
```
<img src=".\media\descarga (1).png" style="width:400px;" />



### Set Theory and Venn Diagrams.
We start by creating sets with the top 50% in each index, and the look for the intersections.

```R
    library(ggvenn)
     x <- list(
         Closeness = Best_Closeness, 
         Degree = Best_Degree,
         Centrality = Best_Centrality,
         Betweenness = Best_Betweenness,
         PageRank = Best_PageRank
        )
    library(VennDiagram)
     display_venn <- function(x, ...){  
      grid.newpage()
      venn_object <- venn.diagram(x, filename = NULL, ...)
      grid.draw(venn_object)
       }
    display_venn(
      x,
      fill = c("#999999", "#E69F00", "#56B4E9", "#469F00", "#E09E75"),
    # Set names
    cat.cex = 1,
    cat.fontface = "bold",
    cat.default.pos = "outer",
    cat.dist = c(0.05, 0.08, 0.08, 0.06, 0.08)
    )
```

<img src=".\media\Fig_3_Venn_Diagrama_1-1.png" style="width:400px;" />

```R
    library(gplots)
    isect <- attr(venn(x, intersection=TRUE), "intersection")
```

Next we will see the size of the intersections in a bar diagram

```R
    library(UpSetR)
     input <- c(
     Centrality = length(isect$Centrality),
     #  Degree =length(isect$Degree),
     PageRank = length(isect$PageRank),
     Closeness =length(isect$Closeness), 
     Betweenness =length(isect$Betweenness),
     # "Degree&Centrality" =  length(isect$`Degree:Centrality`),
     "Degree&PageRank" =  length(isect$`Degree:PageRank`),
     "Degree&Closeness" =  length(isect$`Closeness:Degree`),
     "Degree&Betweenness" =  length(isect$`Degree:Betweenness`),
     "Centrality&PageRank" =  length(isect$`PageRank:Centrality`),
     "Centrality&Closeness" =  length(isect$`Closeness:Centrality`),
     "Centrality&Betweenness" =  length(isect$`Betweenness:Centrality`),
     "PageRank&Closeness" =  length(isect$`Closeness:PageRank`),
     "PageRank&Betweenness" =  length(isect$`Betweenness:PageRank`),
     "Betweenness&Closeness" =  length(isect$`Closeness:Betweenness`),
     "Degree&Centrality&PageRank" =  length(isect$`Degree:Centrality:PageRank`),
     "Degree&Centrality&Closeness" =  length(isect$`Closeness:Degree:Centrality`),
     "Degree&Centrality&Betweenness" =  length(isect$`Degree:Centrality:Betweenness`),
     "Degree&PageRank&Closeness" =  length(isect$`Closeness:Degree:PageRank`),
     "Degree&PageRank&Betweenness" =  length(isect$`Degree:Betweenness:PageRank`),
     "Degree&Closeness&Betweenness" =  length(isect$`Degree:Closeness:Betweenness`),
     "Centrality&PageRank&Closeness" =  length(isect$`PageRank:Centrality:Closeness`),
     "Centrality&PageRank&Betweenness" =  length(isect$`PageRank:Centrality:Betweenness`),
     "Centrality&Closeness&Betweenness" =  length(isect$`Closeness:Centrality:Betweenness`),
     "PageRank&Closeness&Betweenness" =  length(isect$`Closeness:Betweenness:PageRank`),
     "Degree&Centrality&PageRank&Closeness" =  length(isect$`Closeness:Degree:Centrality:PageRank`), 
     "Degree&Centrality&PageRank&Betweenness" =  length(isect$`Degree:Centrality:Betweenness:PageRank`),
     "Centrality&PageRank&Betweenness&Closeness" =  length(isect$`Centrality:PageRank:Betweenness:Closeness`),
     "Degree&PageRank&Betweenness&Closeness" =  length(isect$`Closeness:Degree:Betweenness:PageRank`),
     #  "Degree&Centrality&Betweenness&Closeness" =  length(isect$`Closeness:Degree:Centrality:Betweenness`),
     "Degree&Centrality&PageRank&Betweenness&Closeness" =  length(isect$`Closeness:Degree:Centrality:Betweenness:PageRank`)
    )
     upset(fromExpression(input))
```

<img src=".\media\descarga (3).png" style="width:400px;" />


<div align="justify">These proteins are grouped in modules, this information is in the file "FunctionalModules.csv" also available online at RamirezLab Github (<a href="https://github.com/ramirezlab/WIKI/blob/master/Computational_Polypharmacology/PPI-network-R-TopologyAnalysis/input/FunctionalModules.csv" target="_blank"><b>here</b></a>). This file was generated for our input file using the program MTGO by Vella et al, 2018, available online at https://gitlab.com/d1vella/MTGO where you can find the User manual and the .exe file to download the program. MTGO uses your PPI data, and performs a functional enrichment of significant over represented GO terms.
 We would like too see how much every module add in each topological index. First we read the modules and find out in which module is each protein. The functional modules labeled and visualized in Cytoscape are in the following image for reference.</div>

```R
    Functional_modules <- - read_excel("your-file-location.xlsx")
    Functional_modules <- Functional_modules[-c(1),]

    Vertex$Module <- NA
    for ( i in c( 1:length(rownames(Vertex)) )){
      if(length(which((Functional_modules)== rownames(Vertex)[i], arr.ind =T ) )>0 ){
      cl <- which((Functional_modules)== rownames(Vertex)[i], arr.ind = T)[1,2]
      Vertex$Module[i] <-colnames(Functional_modules)[cl]
     }
    }
```

<img src=".\media\PPI-post-MTGO.jpg" style="width:400px;" />


Now we will rename the modules from GO terms to numbers, in order to make the graphs easy to read.

```R
    Vertex$Module2[Vertex$Module == "Acetylcholine-gated channel"] = "01"
    Vertex$Module2[Vertex$Module == "Adenylate cyclase activity"] = "02"
    Vertex$Module2[Vertex$Module == "Axon"] = "03"
    Vertex$Module2[Vertex$Module == "B cell differentiation"] = "04"
    Vertex$Module2[Vertex$Module == "Cell surface receptor signaling pathway"] = "05"
    Vertex$Module2[Vertex$Module == "Chemokine-mediated signaling pathway"] = "06"
    Vertex$Module2[Vertex$Module == "Early endosome"] = "07"
    Vertex$Module2[Vertex$Module == "GABA-A receptor complex"] = "08"
    Vertex$Module2[Vertex$Module == "Histone deacetylase binding"] = "09"
    Vertex$Module2[Vertex$Module == "Insulin receptor siganling pathway"] = 10
    Vertex$Module2[Vertex$Module == "Magnesium ion binding"] = 11
    Vertex$Module2[Vertex$Module == "Neuropeptide signaling pathway"] = 12
    Vertex$Module2[Vertex$Module == "Oxidation-reduction process"] = 13
    Vertex$Module2[Vertex$Module == "Positivie regulation of peptidyl-tyrosine phosphorilation"] = 14
    Vertex$Module2[Vertex$Module == "Protease binding"] = 15
    Vertex$Module2[Vertex$Module == "RNA pol II distal enhancer sequence-specific DNA binding"] = 16
    Vertex$Module2[Vertex$Module == "Transcription coregulator activity"] = 17
    Vertex$Module2[Vertex$Module == "Transmembrane receptor protein tyrosine kinase signaling"] = 18
    Vertex$Module2[Vertex$Module == "Ubiquitin protein ligase activity"] = 19
    Vertex$Module2[Vertex$Module == "Voltage-gated calcium channel complex"] = 20
```

Now we can do a boxplot for each module in each topological index. The resulting image is the following.

```R
    p0 <- ggplot(subset(Vertex, !is.na(Module2))) +
          geom_boxplot(aes(x = Module2, y=Degree))+
          theme(axis.title.x=element_blank())
    p1 <- ggplot(subset(Vertex, !is.na(Module2))) +
          geom_boxplot(aes(x = Module2, y=Centrality))+
          theme(axis.title.x=element_blank())
    p2 <- ggplot(subset(Vertex, !is.na(Module2))) +
          geom_boxplot(aes(x = Module2, y=Betweenness))+
          theme(axis.title.x=element_blank())
    p3 <- ggplot(subset(Vertex, !is.na(Module2))) +
          geom_boxplot(aes(x = Module2, y=PageRank))+
          theme(axis.title.x=element_blank())
    p4 <- ggplot(subset(Vertex, !is.na(Module2))) +
          geom_boxplot(aes(x = Module2, y=Closeness))+
          theme(axis.title.x=element_blank())        
    multiplot(p0, p1, p2, p3, p4, cols=1 )
```

<img src=".\media\descarga (5).png" style="width:400px;" />


Now, we can also create a barplot graph for each index. The resulting image is found next.

```R
    p0 <- ggplot(subset(Vertex, !is.na(Module2))) +
         geom_col(aes(x = Module2, y=Degree, fill=DegreeCat))+ 
         labs( fill = "", title = "Greater than 50%")+
         theme(axis.title.x=element_blank())
    p1 <- ggplot(subset(Vertex, !is.na(Module2))) +
         geom_col(aes(x = Module2, y=Centrality, fill=CentralityCat))+ 
         labs( fill = "", ) +
         theme(axis.title.x=element_blank())
    p2 <- ggplot(subset(Vertex, !is.na(Module2))) +
         geom_col(aes(x = Module2, y=Betweenness, fill=BetweennessCat))+ 
         labs( fill = "")+
         theme(axis.title.x=element_blank())
    p3 <- ggplot(subset(Vertex, !is.na(Module2))) +
          geom_col(aes(x = Module2, y=PageRank, fill=PageRankCat))+ 
         labs( fill = "")+
         theme(axis.title.x=element_blank())
    p4 <- ggplot(subset(Vertex, !is.na(Module2))) +
         geom_col(aes(x = Module2, y=Closeness, fill=ClosenessCat))+ 
         labs( fill = "") +
         theme(axis.title.x=element_blank())
    multiplot(p0, p1, p2, p3, p4, cols=1 )
```

<img src=".\media\descarga (4).png" style="width:400px;" />


## References
+ Scardoni G, Laudanna C, Tosadori G, Fabbri F, Faizaan M. (2009) Analyzing biological network parameters with CentiScaPe.  Bioinformatics. doi:10.1093/bioinformatics/btp517
