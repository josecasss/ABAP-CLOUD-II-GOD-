define hierarchy ZI_CDS_23_FJCM
  //with parameters
  as parent child hierarchy(
    source ZI_CDS_22_FJCM
    child to parent association _Manager //Asociation to the parent element
    start where
      Manager is initial
    siblings order by
      Employee
    multiple parents allowed
    orphans ignore
    cycles breakup
//    generate spantree 
    cache on
  )
{
  key Employee,
      Manager,
      Name,
      $node.parent_id             as ParentId,
      $node.node_id               as NodeId,
      $node.hierarchy_is_cycle    as HiCycle,
      $node.hierarchy_is_orphan   as HiOrphan,
      $node.hierarchy_level       as HiLevel,
      $node.hierarchy_parent_rank as HiParentRank,
      $node.hierarchy_rank        as HiRank,
      $node.hierarchy_tree_size   as HiTreeSize

}
