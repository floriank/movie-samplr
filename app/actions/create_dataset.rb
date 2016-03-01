class CreateDataset
  def self.for(movie)
    return true if movie.dataset.present?
    worker.perform_async(movie.imdb_id)
  end

  private

  def self.worker
    ImdbDataWorker
  end
end
