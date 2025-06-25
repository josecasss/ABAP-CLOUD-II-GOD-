define hierarchy Z363_14_FJCM
  as parent child hierarchy(
    source Z363_13_FJCM
    child to parent association _Manager //Asociation name
    start where
      Manager is initial                 // Start with initial Manager
    siblings order by
      Employee                           // Order siblings by Employee
    multiple parents allowed             // Allow multiple parents
    orphans ignore                       // Ignore orphans    "This case, the employee without a manager"
    cycles breakup                       // Break cycles
    cache on
  )
{
  key Employee,
      Manager,
      Name,
      $node.parent_id           as ParentId,
      $node.hierarchy_is_orphan as Hlevel,
      $node.hierarchy_tree_size as HSize,
      $node.hierarchy_is_orphan as HOrphan  // To force the hierarchy 
      // $nodea variables for hierarchy



}
